//
//  ListTableViewCell.swift
//  Telephony-Directory
//
//  Created by Rathish Kannan on 7/28/19.
//  Copyright © 2019 Rathish Kannan. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var favoritesImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var item: ResourceCellViewModel? {
        didSet {
            
            guard let item = item else {
                return
            }
            nameLabel.text   = item.title
            avatarImgView.load(URL.init(string: item.title), placeholder: "placeholder_photo", errorPlaceholder: "placeholder_photo")
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImgView.image = nil
        nameLabel.text = nil
        favoritesImgView.image = nil
    }

    
}
