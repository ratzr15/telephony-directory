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
    
    func parseEntityToViewModel(_ entity: Contact) -> ListCellViewModel {
        return ListCellViewModel(id: entity.id ?? 0 , first_name: entity.first_name ?? "", last_name: entity.last_name ?? "", isFavorite: entity.favorite ?? false, profile_pic: entity.profile_pic ?? "", email: entity.email ?? "", phone: entity.phone_number ?? "")
    }
    
    func requestToApi(callback: ((Outcome<[Contact]>) -> ())?) {
        return ContactApiClient.shared.getContacts(callback: callback)
    }

    func requestDetailToApi(id: String, callback: ((Outcome<[Contact]>) -> ())?) {
        return ContactApiClient.shared.getDetail(id: id, callback: callback)
    }
    
}

