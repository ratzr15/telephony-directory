//
//  ListTableViewCell.swift
//  Telephony-Directory
//
//  Created by Rathish Kannan on 7/28/19.
//  Copyright © 2019 Rathish Kannan. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var favoritesBtn: UIButton!
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var messageBtn: UIButton!
    
    var delegate: ContactInformationViewDelegate?

    var item: ResourceCellViewModel? {
        didSet {
            guard let item = item as? ListCellViewModel else {
                return
            }
            nameLabel.text        = item.first_name + item.last_name
            avatarImgView.load(URL.init(string: item.profile_pic))
            favoritesBtn.setImage(UIImage(named: item.isFavorite ? "favourite_button_selected": "favourite_button"), for: .normal)
            phoneNumberLabel.halfColorChangeForText(fullText: "\("mobile   ")\(item.phone ?? "")", changeColortext: "mobile", color: UIColor.lightGray)
            emailLabel.halfColorChangeForText(fullText: "\("email   ")\(item.email ?? "")", changeColortext: "email", color: UIColor.lightGray)
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
    
    @IBAction func message(_ sender: Any) {
        self.delegate?.onEmailClicked()
    }
    
    @IBAction func call(_ sender: Any) {
        self.delegate?.onCallPhoneNumberClicked()

    }
    
    @IBAction func email(_ sender: Any) {
        self.delegate?.onEmailClicked()
    }
    
    @IBAction func favorite(_ sender: Any) {
        self.delegate?.onFavoriteClicked()

    }
}

protocol ContactInformationViewDelegate : AnyObject {
    func onEmailClicked()
    func onCallPhoneNumberClicked()
    func onSmsPhoneNumberClicked()
    func onFavoriteClicked()

}

