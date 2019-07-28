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
            guard let item = item as? ListCellViewModel else {
                return
            }
            nameLabel.text   = item.first_name + item.last_name
            avatarImgView.load(URL.init(string: item.profile_pic))
            
            if item.isFavorite {
                favoritesImgView.image = UIImage(named: "home_favourite")
                favoritesImgView.isHidden = false
            }else {
                favoritesImgView.isHidden = true
            }

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
    }

    
}
