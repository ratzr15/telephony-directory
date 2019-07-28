//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   DetailViewController
//  Description      :   Lists data in table from API
//                       1. Architecture    - MVVM + Rx 
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//----------------------------------------------------------------------------------------------------------------------------------------


import UIKit
import RxSwift

final class DetailViewController: UIViewController, ListResourcesViewController, CanModifyTableView {
    typealias ViewModel = DetailViewModel
    
    // MARK: Fields
    
    var viewModel = ViewModel()
    let bag = DisposeBag()
    
    var identifier : String = ""

    // MARK: Views
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        return table
    }()
    
    lazy var loadingView: LoadingView = {
        return LoadingView()
    }()
    
    lazy var errorView: ErrorView = {
        return ErrorView()
    }()
    
    lazy var sortButton: UIBarButtonItem = {
        return UIBarButtonItem.init(barButtonSystemItem: .add, target: nil, action: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contact"
        setupBindings()
        setupViewHierarchy()
        setupConstraints()
        viewModel.requestResource(id: String(viewModel.resourceEntities[0].id ?? 0))
        navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: Actions

    func onResourceSelection(resource: Contact) {
        
    }
    
    // MARK: Private Methods
    
    private func setupViewHierarchy() {
        view.addSubview(errorView)
        view.addSubview(loadingView)
        view.addSubview(tableView)
        
        tableView.register(UINib(nibName: ListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.identifier)
    }

    private func setupConstraints() {
        errorView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(self.view.safeAreaInsets)
            make.trailing.equalToSuperview().inset(self.view.safeAreaInsets)
            make.top.equalToSuperview().inset(self.view.safeAreaInsets)
            make.bottom.equalToSuperview().inset(self.view.safeAreaInsets)
        }
        loadingView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(self.view.safeAreaInsets)
            make.trailing.equalToSuperview().inset(self.view.safeAreaInsets)
            make.top.equalToSuperview().inset(self.view.safeAreaInsets)
            make.bottom.equalToSuperview().inset(self.view.safeAreaInsets)
        }
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(self.view.safeAreaInsets)
            make.trailing.equalToSuperview().inset(self.view.safeAreaInsets)
            make.top.equalToSuperview().inset(self.view.safeAreaInsets)
            make.bottom.equalToSuperview().inset(self.view.safeAreaInsets)
        }
    }

}
