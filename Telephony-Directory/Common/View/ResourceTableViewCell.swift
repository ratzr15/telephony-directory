//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   ResourceTableViewCell
//  Description      :   TVC for UI
//                       1. Architecture    - MVVM + Rx (Ref: https://github.com/emisvx/mobile-test/tree/development)
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//----------------------------------------------------------------------------------------------------------------------------------------


import UIKit

final class ResourceTableViewCell: UITableViewCell {
    
    static let identifier = "ResourceTableViewCell"
    
    var model: ResourceCellViewModel? {
        didSet {
            self.textLabel?.text = model?.title
        }
    }
}
