//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   ListCellViewModel
//  Description      :   Base resource
//                       1. Architecture    - MVVM + Rx (Ref: https://github.com/emisvx/mobile-test/tree/development)
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//----------------------------------------------------------------------------------------------------------------------------------------


import Foundation

struct ListCellViewModel : ResourceCellViewModel {
    var id: Int
    var first_name: String
    var profile_pic: String

}
