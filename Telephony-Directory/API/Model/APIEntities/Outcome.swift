//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   Outcome
//  Description      :   Result<T> {Swift 5 default}
//                       1. Architecture    - MVVM + Rx (Ref: "")
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//----------------------------------------------------------------------------------------------------------------------------------------


import Foundation

public enum Outcome<E> {
    case success(result: E)
    case failure(error: Error, reason: String)
}
