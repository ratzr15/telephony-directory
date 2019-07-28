//
//  QuickseriesApiClient.swift
//  Quickseries-API
//
//  Created by Thiago Magalhaes on 2019-05-17.
//  Copyright © 2019 Thiago Magalhaes. All rights reserved.
//

import Foundation
import Moya

public class ReviewApiClient : ReviewApi {
    
    public static let shared = ReviewApiClient()
    
    private let provider = MoyaProvider<Reviews>()
    
    public func getReviews(callback: ((Outcome<[Datum]>) -> ())?) {
        provider.request(.getReviews) { result in
            switch result {
            case let .success(response):
                do {
                    let categories = try response.filterSuccessfulStatusCodes().map(Review.self)
                    callback?(.success(result: categories.data))
                } catch (let error) {
                    callback?(.failure(error: error, reason: error.localizedDescription))
                }
            case let .failure(error):
                callback?(.failure(error: error, reason: error.localizedDescription))
            }
        }
    }
    

}
