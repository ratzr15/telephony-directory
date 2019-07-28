//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   ListCellViewModel
//  Description      :   VM for business logic and data manipulation
//                       1. Architecture    - MVVM + Rx (Ref: https://github.com/emisvx/mobile-test/tree/development)
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//----------------------------------------------------------------------------------------------------------------------------------------


import Foundation
import RxRelay

final class ListViewModel : ListResourcesViewModel, CanSortResources {
    var stateMode = ResourceState.add
    typealias Entity = Contact
    typealias EntityViewModel = ListCellViewModel
    
    var resourceEntities = [Contact]()
    let resources = BehaviorRelay<[ListCellViewModel]>(value: [])
    let selectedResource = BehaviorRelay<Contact?>(value: nil)
    let state = BehaviorRelay<ListViewState>(value: .loading)
    
    func parseEntityToViewModel(_ entity: Contact) -> ListCellViewModel {
        return ListCellViewModel(id: entity.id ?? 0 , first_name: entity.first_name ?? "", profile_pic: entity.profile_pic ?? "")
    }
    
    func requestToApi(callback: ((Outcome<[Contact]>) -> ())?) {
        return ContactApiClient.shared.getContacts(callback: callback)
    }
}
