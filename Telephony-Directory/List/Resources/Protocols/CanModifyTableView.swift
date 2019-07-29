//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   CanModifyTableView
//  Description      :   UIBarButtonItem sort
//                       1. Architecture    - MVVM + Rx (Ref: "")
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//----------------------------------------------------------------------------------------------------------------------------------------


import Foundation
import UIKit
import RxCocoa

protocol CanModifyTableView {
 
    var modifyButton: UIBarButtonItem { get }
}

extension CanModifyTableView where Self : ListResourcesViewController, Self.ViewModel : CanModifyResources {
    
    func setupSortButton() {
        modifyButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.viewModel.onStateClicked()
            })
            .disposed(by: bag)
        navigationItem.rightBarButtonItem = modifyButton
    }
}
