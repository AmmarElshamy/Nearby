//
//  PlacesListViewController.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import UIKit
import RxSwift
import RxCocoa

class PlacesListViewController: UIViewController {
    
    // MARK: Creator
    static func create() -> PlacesListViewController {
        let viewModel = DiManager.assembler.resolver.resolve(PlacesListViewModel.self)!
        let vc = PlacesListViewController(viewModel)
        return vc
    }
    
    // MARK: Outlets
    @IBOutlet var loaderView: UIActivityIndicatorView!
    @IBOutlet var placesTableView: UITableView!
    
    // MARK: CustomViews
    private lazy var tableBackgroundView = {
        TableBackgroundView()
    }()
    
    private let modeButton: UIBarButtonItem = {
        UIBarButtonItem()
    }()
    
    // MARK: Properties
    private let viewModel: PlacesListViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: Initializers
    private init(_ viewModel: PlacesListViewModel) {
        self.viewModel = viewModel
        super.init(
            nibName: PlacesListViewController.fileName,
            bundle: PlacesListViewController.bundle
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
        subscribeOnState()
    }
    
    private func setupViews() {
        setupNavigationBar()
        setupPlacesTableView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Places"
        navigationItem.rightBarButtonItem = modeButton
    }
    
    private func setupPlacesTableView() {
        placesTableView.register(
            .create(for: PlaceTableViewCell.self),
            forCellReuseIdentifier: PlaceTableViewCell.fileName
        )
    }
    
    private func bindViewModel() {
        
        viewModel.mode.map({
            switch $0 {
            case .realTime:
                return "Single Update"
            case .singleUpdate:
                return "Realtime"
            }
        }).bind(to: modeButton.rx.title).disposed(by: disposeBag)
        
        modeButton.rx.tap.bind(to: viewModel.modeButtonSubject).disposed(by: disposeBag)
        
        viewModel.cellViewModels.bind(to: placesTableView.rx.items) { tableView, index, viewModel in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PlaceTableViewCell.fileName,
                for: IndexPath(row: index, section: 0)
            )
            (cell as? PlaceTableViewCell)?.bind(viewModel)
            return cell
        }.disposed(by: disposeBag)
        
        placesTableView
            .rx
            .willDisplayCell
            .map({ $0.indexPath.row })
            .subscribe(onNext: { [weak self]index in
                guard let self = self else { return }
                if index == self.placesTableView.numberOfRows(inSection: 0) - 4 {
                    self.viewModel.fetchMorePlaces()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func subscribeOnState() {
        viewModel.viewState.subscribe(onNext: { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .normal:
                self.loaderView.stopAnimating()
                self.placesTableView.backgroundView = nil
                self.configureTableViewVisibility(isHidden: false)
                
            case .empty:
                self.loaderView.stopAnimating()
                self.tableBackgroundView.set(state: .empty)
                self.placesTableView.backgroundView = self.tableBackgroundView
                self.configureTableViewVisibility(isHidden: false)
                
            case .loading:
                self.loaderView.isHidden = false
                self.loaderView.startAnimating()
                self.configureTableViewVisibility(isHidden: true)
                
            case .error:
                self.loaderView.stopAnimating()
                self.tableBackgroundView.set(state: .error)
                self.placesTableView.backgroundView = self.tableBackgroundView
                self.configureTableViewVisibility(isHidden: false)
                
            }
        }).disposed(by: disposeBag)
    }
    
    private func configureTableViewVisibility(isHidden: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.placesTableView.alpha = isHidden ? 0 : 1
        }
    }
}
