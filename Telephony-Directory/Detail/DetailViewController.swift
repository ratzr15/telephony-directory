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
import RxCocoa
import MessageUI
import SafariServices

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
    
    lazy var modifyButton: UIBarButtonItem = {
        return UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editContact(sender:)))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupViewHierarchy()
        setupConstraints()
        setupNavigationButton()
        viewModel.requestResource(id: String(viewModel.resourceEntities[0].id ?? 0))
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func setupBindings() {
        viewModel.selectedEmail
            .flatMap({ return $0 == nil ? Observable.empty() : Observable.just($0!) })
            .subscribe(onNext: { [weak self] email in self?.composeEmail(email: email) })
            .disposed(by: bag)
        
        viewModel.selectedCallPhoneNumber
            .flatMap({ return $0 == nil ? Observable.empty() : Observable.just($0!) })
            .subscribe(onNext: { [weak self] number in self?.callNumber(number: number) })
            .disposed(by: bag)
        
        viewModel.selectedSmsPhoneNumber
            .flatMap({ return $0 == nil ? Observable.empty() : Observable.just($0!) })
            .subscribe(onNext: { [weak self] number in self?.smsNumber(number: number) })
            .disposed(by: bag)

        bindTableViewData()
        subscribeToViewModelState()
    }

    // MARK: Actions

    func onResourceSelection(resource: Contact) {
        
    }
    
    // MARK: Private Methods
    
    private func setupViewHierarchy() {
        view.addSubview(errorView)
        view.addSubview(loadingView)
        view.addSubview(tableView)
        tableView.register(UINib(nibName: DetailTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.identifier)
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


extension DetailViewController {
    fileprivate func bindTableViewData() {
        viewModel.resources.asObservable()
            .bind(to:tableView.rx.items) { (tableView, row, element) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
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
                case .displayingData:
                    self?.loadingView.isHidden = true
                    self?.errorView.isHidden = true
                    self?.tableView.isHidden = false
                }
            })
        }).disposed(by: bag)
    }
}

extension DetailViewController {
    fileprivate func composeEmail(email: String) {
        guard MFMailComposeViewController.canSendMail() else {
            showFeatureNotSupportedAlert()
            return
        }
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients([email])
        mail.setMessageBody("", isHTML: true)
        present(mail, animated: true)
    }
    
    fileprivate func callNumber(number: String) {
        guard let number = URL(string: "tel://" + number), UIApplication.shared.canOpenURL(number) else {
            showFeatureNotSupportedAlert()
            return
        }
        UIApplication.shared.open(number)
    }

    fileprivate func smsNumber(number: String) {
        guard MFMessageComposeViewController.canSendText() else {
            showFeatureNotSupportedAlert()
            return
        }
        let sms = MFMessageComposeViewController()
        sms.messageComposeDelegate = self
        sms.recipients = [number]
        present(sms, animated: true)
    }

    private func showFeatureNotSupportedAlert(message: String = "Your device does not support this feature") {
        let alert = UIAlertController(title: "Failure", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Discard", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}

extension DetailViewController : MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true)
    }
}


extension DetailViewController {
    @objc func editContact(sender: UIBarButtonItem){
        var controller: UIViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: String(describing: EditViewController.self)) as! EditViewController
        }
        
        let  viewController = controller as! EditViewController
        viewController.viewModel.passModel(model:viewModel.resources.value[0] )
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }

}
