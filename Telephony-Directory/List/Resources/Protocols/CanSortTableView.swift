//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   CanSortTableView
//  Description      :   UIBarButtonItem sort
//                       1. Architecture    - MVVM + Rx (Ref: https://github.com/emisvx/mobile-test/tree/development)
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//----------------------------------------------------------------------------------------------------------------------------------------


import Foundation
import UIKit
import RxCocoa

protocol CanSortTableView {
 
    var sortButton: UIBarButtonItem { get }
}

extension CanSortTableView where Self : ListResourcesViewController, Self.ViewModel : CanSortResources {
    
    func setupSortButton() {
        sortButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.viewModel.onSortClicked()
            })
            .disposed(by: bag)
        navigationItem.rightBarButtonItem = sortButton
    }
}
