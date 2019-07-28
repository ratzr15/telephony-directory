//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   CanSortResources
//  Description      :   Confirm to this proocol to add a sort button on navigation with sorting loagic (onSortClicked)
//                       1. Architecture    - MVVM + Rx (Ref: https://github.com/emisvx/mobile-test/tree/development)
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//----------------------------------------------------------------------------------------------------------------------------------------


import Foundation

protocol CanSortResources {
    
    var sortState: ResourceSortState { get set}
}

extension CanSortResources where Self : ListResourcesViewModel {
    
    func sortResources(_ r: [Self.Entity]) -> [Self.Entity] {
        switch sortState {
        case .alphabetically:
            return r.sorted { $0.title ?? "" < $1.title ?? ""}
        case .reverseAlphabetically:
            return r.sorted { $0.title ?? "" > $1.title ?? "" }
        case .unsorted:
            return r
        }
    }
    
    mutating func onSortClicked() {
        switch sortState {
        case .alphabetically:
            sortState = .reverseAlphabetically
        default:
            sortState = .alphabetically
        }
        resourceEntities = sortResources(resourceEntities)
        resources.accept(resourceEntities.map({ parseEntityToViewModel($0) }))
    }
}

enum ResourceSortState {
    case alphabetically
    case reverseAlphabetically
    case unsorted
}
