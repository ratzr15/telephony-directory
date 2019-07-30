//
//  ListTableViewCell.swift
//  Telephony-Directory
//
//  Created by Rathish Kannan on 7/28/19.
//  Copyright © 2019 Rathish Kannan. All rights reserved.
//

import UIKit
import RxSwift

class AddTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var changeImageButton: UIButton!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    private let bag = DisposeBag()
    
    var delegate: ContactDelegate?

    var item: ResourceCellViewModel? {
        didSet {
            guard let item = item as? ListCellViewModel else {
                return
            }
            avatarImgView.load(URL.init(string: item.profile_pic))
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
    }
    
    @IBAction func changeImage(_ sender: Any) {
        
    }
    
    
    @IBAction func done(_ sender: Any) {
        self.delegate?.onDone(ListCellViewModel.init(id: 1, first_name: firstNameTextField.text ?? "", last_name: lastNameTextField.text ?? "", isFavorite: false, profile_pic: "", email:emailTextField.text ?? "", phone: mobileTextField.text ?? ""), action: .add)
    }
    
}


protocol ContactDelegate : AnyObject {
    func onDone(_ contact: ListCellViewModel, action: ResourceState)
}

