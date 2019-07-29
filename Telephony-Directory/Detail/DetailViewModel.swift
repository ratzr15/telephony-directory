//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   ListCellViewModel
//  Description      :   VM for business logic and data manipulation
//                       1. Architecture    - MVVM + Rx 
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//----------------------------------------------------------------------------------------------------------------------------------------


import Foundation
import RxRelay

final class DetailViewModel : ListResourcesViewModel, CanModifyResources {
    var stateMode = ResourceState.edit
    typealias Entity = Contact
    typealias EntityViewModel = ListCellViewModel
    
    var resourceEntities = [Contact]()
    let resources = BehaviorRelay<[ListCellViewModel]>(value: [])
    let selectedResource = BehaviorRelay<Contact?>(value: nil)
    let state = BehaviorRelay<ListViewState>(value: .loading)

    let viewState = ResourceState.add
    
    var model: Contact {
        return resourceEntities[0]
    }
    
    let selectedEmail = BehaviorRelay<String?>(value: nil)
    let selectedCallPhoneNumber = BehaviorRelay<String?>(value: nil)
    let selectedSmsPhoneNumber = BehaviorRelay<String?>(value: nil)

    func parseEntityToViewModel(_ entity: Contact) -> ListCellViewModel {
        return ListCellViewModel(id: entity.id ?? 0 , first_name: entity.first_name ?? "", last_name: entity.last_name ?? "", isFavorite: entity.favorite ?? false, profile_pic: entity.profile_pic ?? "", email: entity.email ?? "", phone: entity.phone_number ?? "", type: .detail)
    }
    
    func requestToApi(callback: ((Outcome<[Contact]>) -> ())?) {
        return ContactApiClient.shared.getContacts(callback: callback)
    }

    func requestDetailToApi(id: String, callback: ((Outcome<[Contact]>) -> ())?) {
        return ContactApiClient.shared.getDetail(id: id, callback: callback)
    }
    
}


extension DetailViewModel : ContactInformationViewDelegate {
    func onEmailClicked() {
        if let email = model.email {
            selectedEmail.accept(email)
        }
    }
    
    func onCallPhoneNumberClicked() {
        if let number = model.phone_number {
            selectedCallPhoneNumber.accept(number)
        }
    }
    
    func onSmsPhoneNumberClicked() {
        if let number = model.phone_number {
            selectedSmsPhoneNumber.accept(number)
        }
    }
    
}



