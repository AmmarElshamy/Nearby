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
    @IBOutlet var placesTableView: UITableView!
    
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
    }
    
    private func setupViews() {
        setupNavigationBar()
        setupPlacesTableView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Places"
    }
    
    private func setupPlacesTableView() {
        placesTableView.register(
            .create(for: PlaceTableViewCell.self),
            forCellReuseIdentifier: PlaceTableViewCell.fileName
        )
    }
    
    private func bindViewModel() {
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
}
