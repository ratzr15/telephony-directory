//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   CanModifyResources
//  Description      :   Confirm to this proocol to add a sort button on navigation with sorting loagic (onSortClicked)
//                       1. Architecture    - MVVM + Rx (Ref: "")
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//----------------------------------------------------------------------------------------------------------------------------------------


import Foundation
import UIKit

protocol CanModifyResources {
    
    var stateMode: ResourceState { get set}
    
}

extension CanModifyResources where Self : ListResourcesViewModel {
    
    func resources(_ r: [Self.Entity]) -> [Self.Entity] {
        return r
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
    case view

}

public extension UIDevice {
    
    var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    enum ScreenType: String {
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6Plus
        case iPhoneX
        case Unknown
    }
    var screenType: ScreenType {
        guard iPhone else { return .Unknown}
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4
        case 1136:
            return .iPhone5
        case 1334:
            return .iPhone6
        case 2208, 1920:
            return .iPhone6Plus
        case 2436:
            return .iPhoneX
        default:
            return .Unknown
        }
    }
    
}
