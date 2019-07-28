//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   CanModifyResources
//  Description      :   Confirm to this proocol to add a sort button on navigation with sorting loagic (onSortClicked)
//                       1. Architecture    - MVVM + Rx (Ref: https://github.com/emisvx/mobile-test/tree/development)
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//----------------------------------------------------------------------------------------------------------------------------------------


import Foundation

protocol CanModifyResources {
    
    var stateMode: ResourceState { get set}
}

extension CanModifyResources where Self : ListResourcesViewModel {
    
    func resources(_ r: [Self.Entity]) -> [Self.Entity] {
      
        return []
    }
    
    mutating func onStateClicked() {
        resourceEntities = resources(resourceEntities)
        resources.accept(resourceEntities.map({ parseEntityToViewModel($0) }))
    }
}

enum ResourceState {
    case add
    case edit
    case remove
}
