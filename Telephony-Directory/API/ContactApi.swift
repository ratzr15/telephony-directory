//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   API Blueprint
//  Description      :   ViewModel for Data logic
//                       1. Architecture    - MVVM + Rx (Ref: "")
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//----------------------------------------------------------------------------------------------------------------------------------------


import Foundation

public protocol ContactApi {
    func getContacts(callback: ((Outcome<[Contact]>) -> ())?)
    func getDetail(id:String, callback: ((Outcome<[Contact]>) -> ())?)
    func addContact(contact:ListCellViewModel, callback: ((Outcome<[Contact]>) -> ())?)
    func editContact(contact:ListCellViewModel, callback: ((Outcome<[Contact]>) -> ())?)

}

