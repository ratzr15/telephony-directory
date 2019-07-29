//---------------------------------------------------------------------------------------------------------------------------------------
//  File Name        :   ListResourcesViewModel
//  Description      :   ViewModel for Data logic
//                       1. Architecture    - MVVM + Rx (Ref: "")
//  Author            :  Rathish Kannan
//  E-mail            :  rathishnk@hotmail.co.in
//  Dated             :  22nd July 2019
//  Copyright (c) 2019-20 Rathish Kannan. All rights reserved.
//----------------------------------------------------------------------------------------------------------------------------------------


import Foundation
import RxRelay

protocol ListResourcesViewModel : AnyObject {
    
    associatedtype Entity : Resource
    associatedtype EntityCellViewModel : ResourceCellViewModel
    
    var resourceEntities: [Entity] { get set }
    var resources: BehaviorRelay<[EntityCellViewModel]> { get }
    var selectedResource: BehaviorRelay<Entity?> { get }
    var state: BehaviorRelay<ListViewState> { get }
    
    func requestToApi(callback: ((Outcome<[Entity]>) -> ())?)
    func parseEntityToViewModel(_ entity: Entity) -> EntityCellViewModel
    func requestResources()
    
    func requestDetailToApi(id:String,
                            callback: ((Outcome<[Entity]>) -> ())?)
    func requestResource(id:String)
    
    
}

extension ListResourcesViewModel {
    
    func requestResource(id:String) {
        requestDetailToApi(id:id){ outcome in
            switch outcome {
            case .success(let result):
                self.resourceEntities = result
                let viewModels = result.map({ return self.parseEntityToViewModel($0)})
                self.resources.accept(viewModels)
                self.state.accept(.displayingData)
            case .failure(let error, let reason):
                print(error)
                self.resourceEntities = []
                self.resources.accept([])
                self.state.accept(.error(errorMessage: reason))
            }
        }
    }
    func requestResources() {
        requestToApi { outcome in
            switch outcome {
            case .success(let result):
                self.resourceEntities = result
                let viewModels = result.map({ return self.parseEntityToViewModel($0)})
                self.resources.accept(viewModels)
                self.state.accept(.displayingData)
            case .failure(let error, let reason):
                print(error)
                self.resourceEntities = []
                self.resources.accept([])
                self.state.accept(.error(errorMessage: reason))
            }
        }
    }
    
    func onResourceSelected(resource: EntityCellViewModel) {
        if let entity = resourceEntities.first(where: {$0.id == resource.id}) {
            selectedResource.accept(entity)
        }
    }
}

enum ListViewState {
    case error(errorMessage: String)
    case loading
    case displayingData
}
