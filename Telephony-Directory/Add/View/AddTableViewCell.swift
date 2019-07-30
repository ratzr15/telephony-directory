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
            setUpDelegates()
            vm = item

            if item.type == .edit {
                fillTexts(item: item)
            }
        }
    }
    
    var vm: ListCellViewModel!
    
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
    
    private func setUpDelegates(){
        emailTextField.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        mobileTextField.delegate = self
    }
    
    private func fillTexts(item:ListCellViewModel){
        emailTextField.text = item.email
        firstNameTextField.text = item.first_name
        lastNameTextField.text = item.last_name
        mobileTextField.text = item.phone
    }
    
    @IBAction func changeImage(_ sender: Any) {
        
    }
    
    
    @IBAction func done(_ sender: Any) {
        self.delegate?.onDone(ListCellViewModel.init(id: vm.id, first_name: firstNameTextField.text ?? "", last_name: lastNameTextField.text ?? "", isFavorite: false, profile_pic: "", email:emailTextField.text ?? "", phone: mobileTextField.text ?? ""), action: .add)
    }
    
}


extension AddTableViewCell: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

protocol ContactDelegate : AnyObject {
    func onDone(_ contact: ListCellViewModel, action: ResourceState)
}

