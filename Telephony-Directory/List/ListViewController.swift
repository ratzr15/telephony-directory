//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   ListViewController
//  Description      :   Lists data in table from API
//                       1. Architecture    - MVVM + Rx (Ref: https://github.com/emisvx/mobile-test/tree/development)
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//----------------------------------------------------------------------------------------------------------------------------------------


import UIKit
import RxSwift

final class ListViewController: UIViewController, ListResourcesViewController {

    typealias ViewModel = ListViewModel
    
    // MARK: Fields
    
    var viewModel = ViewModel()
    let bag = DisposeBag()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reviews"
        setupBindings()
        setupViewHierarchy()
        setupConstraints()
        viewModel.requestResources()
    }
    
    // MARK: Actions

    func onResourceSelection(resource: Datum) {
        
    }
    
    // MARK: Private Methods
    
    private func setupViewHierarchy() {
        view.addSubview(errorView)
        view.addSubview(loadingView)
        view.addSubview(tableView)
        tableView.register(ResourceTableViewCell.self, forCellReuseIdentifier: ResourceTableViewCell.identifier)
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
