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

final class EditViewModel : ListResourcesViewModel, CanModifyResources {
    var stateMode = ResourceState.add
    typealias Entity = Contact
    typealias EntityViewModel = ListCellViewModel
    
    var resourceEntities = [Contact]()
    var resources = BehaviorRelay<[ListCellViewModel]>(value: [])
    let selectedResource = BehaviorRelay<Contact?>(value: nil)
    let state = BehaviorRelay<ListViewState>(value: .loading)

    let viewState = ResourceState.add
    
    let selectedDone = BehaviorRelay<[ListCellViewModel]>(value: [])
    let selectedCancel = BehaviorRelay<String?>(value: nil)

    var model: Contact {
        return resourceEntities[0]
    }
    
    func parseEntityToViewModel(_ entity: Contact) -> ListCellViewModel {
        return ListCellViewModel(id: entity.id ?? 0 , first_name: entity.first_name ?? "", last_name: entity.last_name ?? "", isFavorite: entity.favorite ?? false, profile_pic: entity.profile_pic ?? "", email: entity.email ?? "", phone: entity.phone_number ?? "", type: .edit)
    }
    
    func requestToApi(callback: ((Outcome<[Contact]>) -> ())?) {
        return ContactApiClient.shared.getContacts(callback: callback)
    }

    func requestDetailToApi(id: String, callback: ((Outcome<[Contact]>) -> ())?) {
        return ContactApiClient.shared.getDetail(id: id, callback: callback)
    }
    
    func passModel(model:ListCellViewModel) {
        self.state.accept(.displayingData)
        var passedModel = model
        passedModel.type = .edit
        self.resources.accept([passedModel])
    }
    
    func editToApi(contact: ListCellViewModel, callback: ((Outcome<[Contact]>) -> ())?) {
        return ContactApiClient.shared.editContact(contact: contact, callback: callback)
    }
    
    func addToApi(contact: ListCellViewModel, callback: ((Outcome<[Contact]>) -> ())?) {
        
    }
}


extension EditViewModel : ContactDelegate {
    func onDone(_ contact: ListCellViewModel, action: ResourceState) {
        selectedDone.accept([contact])
    }

}
