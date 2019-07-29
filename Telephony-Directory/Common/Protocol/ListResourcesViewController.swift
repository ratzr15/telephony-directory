//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   ListResourcesViewController
//  Description      :   Base to manange the datas across view controller
//                       1. Architecture    - MVVM + Rx (Ref: "")
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//----------------------------------------------------------------------------------------------------------------------------------------

import Foundation
import RxSwift
import RxCocoa

protocol ListResourcesViewController : UIViewController {
    
    associatedtype ViewModel : ListResourcesViewModel
    
    var viewModel: ViewModel { get set }
    var bag: DisposeBag { get }
    
    var tableView: UITableView { get }
    var loadingView: LoadingView { get }
    var errorView: ErrorView { get }
    
    func onResourceSelection(resource: ViewModel.Entity)
}

extension ListResourcesViewController {
    
    func setupBindings() {
        bindTableViewData()
        bindTableViewSelection()
        subscribeToModelSelection()
        subscribeToViewModelState()
    }
    
    fileprivate func bindTableViewData() {
        viewModel.resources.asObservable()
            .bind(to:tableView.rx.items) { (tableView, row, element) in
                guard let item = element as? ListCellViewModel else {
                    return UITableViewCell()
                }
                switch item.type{
                case .list: return self.list(row: row, element: item) ?? UITableViewCell()
                case .detail: return self.detail(row: row, element: item) ?? UITableViewCell()
                default: return self.list(row: row, element: item) ?? UITableViewCell()
                }
            }
            .disposed(by: bag)
    }

    fileprivate func list(row:Int,element:ListCellViewModel) -> UITableViewCell? {
        let indexPath = IndexPath(row: row, section: 0)
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        cell.item = element
        return cell
    }
    
    fileprivate func detail(row:Int,element:ListCellViewModel) -> UITableViewCell? {
        let indexPath = IndexPath(row: row, section: 0)
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
        cell.item = element
        return cell
    }
    
    fileprivate func bindTableViewSelection() {
        tableView.rx
            .modelSelected(Self.ViewModel.EntityCellViewModel.self)
            .subscribe(onNext: { [weak self] in self?.viewModel.onResourceSelected(resource: $0) })
            .disposed(by: bag)
    }
    
    fileprivate func subscribeToModelSelection() {
        viewModel.selectedResource
            .flatMap({ model -> Observable<Self.ViewModel.Entity> in
                if let model = model {
                    return Observable.just(model)
                } else {
                    return Observable.empty()
                }
            })
            .subscribe(onNext: { [weak self] resource in
                if let selected = self?.tableView.indexPathForSelectedRow {
                    self?.tableView.deselectRow(at: selected, animated: true)
                }
                self?.onResourceSelection(resource: resource)
            }).disposed(by: bag)
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
                case .displayingData:
                    self?.loadingView.isHidden = true
                    self?.errorView.isHidden = true
                    self?.tableView.isHidden = false
                }
            })
        }).disposed(by: bag)
    }
}

extension ListResourcesViewController where Self : CanModifyTableView, Self.ViewModel : CanModifyResources {
    
    func setupBindings() {
        bindTableViewData()
        bindTableViewSelection()
        subscribeToModelSelection()
        subscribeToViewModelState()
        setupSortButton()
    }
}
