//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   ListCellViewModel
//  Description      :   Base resource
//                       1. Architecture    - MVVM + Rx (Ref: "")
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//----------------------------------------------------------------------------------------------------------------------------------------


import Foundation

public struct ListCellViewModel : ResourceCellViewModel {
    var id: Int
    var first_name: String
    let last_name: String
    let isFavorite: Bool
    var profile_pic: String
    
    var email: String? = nil
    var phone: String? = nil
    
    var type: ViewType = .list

    init(id: Int, first_name: String, last_name: String, isFavorite:Bool,profile_pic:String,email: String? = nil, phone: String? = nil, type: ViewType = .list) {
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.isFavorite = isFavorite
        self.profile_pic = profile_pic
        self.email = email
        self.phone = phone
        self.type = type
    }
    
   
    
}
