//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   ListViewController
//  Description      :   Lists data in table from API
//                       1. Architecture    - MVVM + Rx 
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//----------------------------------------------------------------------------------------------------------------------------------------


import UIKit
import RxSwift

final class ListViewController: UIViewController, ListResourcesViewController, CanModifyTableView {
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
    
    lazy var modifyButton: UIBarButtonItem = {
        return UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addContact(sender:)))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contact"
        setupBindings()
        setupViewHierarchy()
        setupConstraints()
        viewModel.requestResources()
        view.accessibilityIdentifier = "contactListView"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: Actions

    func onResourceSelection(resource: Contact) {
        var controller: UIViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as! DetailViewController
        }
        
        let  viewController = controller as! DetailViewController
        viewController.viewModel.resourceEntities = [resource]
        self.navigationController?.pushViewController(viewController, animated: true)
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

extension ListViewController {
     @objc func addContact(sender: UIBarButtonItem){
        var controller: UIViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: String(describing: AddViewController.self)) as! AddViewController
        }
        
        let  viewController = controller as! AddViewController
        present(viewController, animated: true, completion: nil)
    }
}
