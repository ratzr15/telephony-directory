//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   Cell Display VM
//  Description      :   ViewModel for Data logic
//                       1. Architecture    - MVVM + Rx (Ref: "")
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//----------------------------------------------------------------------------------------------------------------------------------------


import Foundation

protocol ResourceCellViewModel {
    var id: Int { get }
    var first_name: String { get }
}

protocol ContactInformationViewDelegate : AnyObject {
    func onEmailClicked()
    func onCallPhoneNumberClicked()
    func onSmsPhoneNumberClicked()
}
