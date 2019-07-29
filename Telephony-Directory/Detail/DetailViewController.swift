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
        return UIBarButtonItem(title: "Edit", style: .plain, target: nil, action: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupViewHierarchy()
        setupConstraints()
        setupDetailBindings()
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
    
    private func setupDetailBindings() {
        
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
