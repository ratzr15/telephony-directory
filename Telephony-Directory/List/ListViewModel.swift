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

final class ListViewModel : ListResourcesViewModel {
 
    typealias Entity = Datum
    typealias EntityViewModel = ListCellViewModel
    
    var resourceEntities = [Datum]()
    let resources = BehaviorRelay<[ListCellViewModel]>(value: [])
    let selectedResource = BehaviorRelay<Datum?>(value: nil)
    let state = BehaviorRelay<ListViewState>(value: .loading)
    
    func parseEntityToViewModel(_ entity: Datum) -> ListCellViewModel {
        return ListCellViewModel(reviewID: entity.reviewID , title: entity.title ?? "")
    }
    
    func requestToApi(callback: ((Outcome<[Datum]>) -> ())?) {
        return ReviewApiClient.shared.getReviews(callback: callback)
    }
}
