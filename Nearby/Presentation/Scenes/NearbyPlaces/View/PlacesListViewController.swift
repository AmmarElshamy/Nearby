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
        let viewModel = PlacesListViewModel()
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
    }
    
}
