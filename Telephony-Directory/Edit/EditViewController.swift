//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   EditViewController
//  Description      :   Edit contact data in table through API
//                       1. Architecture    - MVVM + Rx 
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//----------------------------------------------------------------------------------------------------------------------------------------


import UIKit
import RxSwift
import RxCocoa

final class EditViewController: UIViewController, ListResourcesViewController, CanModifyTableView {
    typealias ViewModel = AddViewModel
    
    // MARK: Fields
    
    var viewModel = ViewModel(){
        didSet{
            tableView.reloadData()
        }
    }
    
    var cellViewModel = ListCellViewModel.init(id: 0, first_name: "", last_name: "", isFavorite: false, profile_pic: "")

    let bag = DisposeBag()
    
    lazy var modifyButton: UIBarButtonItem = {
        return UIBarButtonItem(title: "Done", style: .plain, target: nil, action: nil)
    }()

    // MARK: Views
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.separatorStyle = .none
        table.separatorColor = UIColor.clear
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
        bindTableViewData()
        setUpAddBindings()
        subscribeToViewModelState()
        setupViewHierarchy()
        setupConstraints()
        viewModel.requestAddModel()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    fileprivate func setUpAddBindings(){
        /*viewModel.selectedDone
            .flatMap({ return $0 == nil ? Observable.empty() : Observable.just($0!) })
            .subscribe(onNext: { [weak self] model in self?.addContact(model: model[0])})
            .disposed(by:bag)*/
        
        
        viewModel.selectedDone
            .flatMap({ return $0 == nil ? Observable.empty() : Observable.just($0!) })
            .subscribe { event in
                switch event {
                case .next(let value):
                    if value.count >  0 {
                        self.addContact(model: value[0])
                    }
                case .error(let error):
                    print(error)
                case .completed:
                    print("completed")
                }
            }.disposed(by:bag)}
    
    // MARK: Actions

    func onResourceSelection(resource: Contact) {
        
    }
    
    // MARK: Private Methods
    
    private func setupViewHierarchy() {
        view.addSubview(errorView)
        view.addSubview(loadingView)
        view.addSubview(tableView)
        tableView.register(UINib(nibName: AddTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AddTableViewCell.identifier)
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

extension EditViewController {
    fileprivate func bindTableViewData() {
        viewModel.resources.asObservable()
            .bind(to:tableView.rx.items) { (tableView, row, element) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: AddTableViewCell.identifier, for: indexPath) as! AddTableViewCell
                cell.item = element
                cell.delegate = self.viewModel
                return cell
            }
            .disposed(by: bag)
    }
    
    fileprivate func subscribeToViewModelState() {
        viewModel.state.subscribe(onNext: { [weak self] state in
            UIView.animate(withDuration: 0.5, animations: {
                switch state {
                case .loading:
                    self?.loadingView.isHidden = false
                    self?.errorView.isHidden = true
                    self?.tableView.isHidden = true
                case .error(let message):
                    self?.loadingView.isHidden = true
                    self?.errorView.isHidden = false
                    self?.errorView.messageLabel.text = message
                    self?.tableView.isHidden = true
                    self?.showFeatureNotSupportedAlert(message: "Error encountered")
                case .displayingData:
                    self?.loadingView.isHidden = true
                    self?.errorView.isHidden = true
                    self?.tableView.isHidden = false
                    self?.showFeatureNotSupportedAlert(message: "Successfully added contact")
                }
            })
        }).disposed(by: bag)
    }
}


extension EditViewController {
    fileprivate func addContact(model: ListCellViewModel) {
        if !model.first_name.isEmpty || model.first_name != "" || !model.last_name.isEmpty || model.last_name != ""{
            viewModel.addResource(contact: model)
        }else{
            showFeatureNotSupportedAlert(message: "Mandatory fields not filled")
        }
    }
    
    fileprivate func showFeatureNotSupportedAlert(message: String = "Your device does not support this feature") {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Discard", style: .cancel, handler: {(action: UIAlertAction) -> Void in
            self.dismiss(animated: true, completion: nil) })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}
