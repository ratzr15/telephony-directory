//
//  QuickseriesApiClient.swift
//  Quickseries-API
//
//  Created by Rathish Kannan on 2019-05-17.
//  Copyright © 2019 Rathish Kannan. All rights reserved.
//

import Foundation
import Moya

public class ContactApiClient : ContactApi {
    
    public static let shared = ContactApiClient()
    
    private let provider = MoyaProvider<Contacts>()
    
    public func getContacts(callback: ((Outcome<[Contact]>) -> ())?) {
        provider.request(.getContacts) { result in
            switch result {
            case let .success(response):
                do {
                    let categories = try response.filterSuccessfulStatusCodes().map([Contact].self)
                    callback?(.success(result: categories))
                } catch (let error) {
                    callback?(.failure(error: error, reason: error.localizedDescription))
                }
            case let .failure(error):
                callback?(.failure(error: error, reason: error.localizedDescription))
            }
        }
    }
    
    public func getDetail(id:String, callback: ((Outcome<[Contact]>) -> ())?) {
        provider.request(.getDetail(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let categories = try response.filterSuccessfulStatusCodes().map(Contact.self)
                    callback?(.success(result: [categories]))
                } catch (let error) {
                    callback?(.failure(error: error, reason: error.localizedDescription))
                }
            case let .failure(error):
                callback?(.failure(error: error, reason: error.localizedDescription))
            }
        }
    }

    public func addContact(contact:ListCellViewModel, callback: ((Outcome<[Contact]>) -> ())?) {
        provider.request(.addContact(contact: contact)) { result in
            switch result {
            case let .success(response):
                do {
                    let categories = try response.filterSuccessfulStatusCodes().map(Contact.self)
                    callback?(.success(result: [categories]))
                } catch (let error) {
                    callback?(.failure(error: error, reason: error.localizedDescription))
                }
            case let .failure(error):
                callback?(.failure(error: error, reason: error.localizedDescription))
            }
        }
    }
    
    public func editContact(contact:ListCellViewModel, callback: ((Outcome<[Contact]>) -> ())?) {
        provider.request(.editContact(contact: contact)) { result in
            switch result {
            case let .success(response):
                do {
                    let categories = try response.filterSuccessfulStatusCodes().map(Contact.self)
                    callback?(.success(result: [categories]))
                } catch (let error) {
                    callback?(.failure(error: error, reason: error.localizedDescription))
                }
            case let .failure(error):
                callback?(.failure(error: error, reason: error.localizedDescription))
            }
        }
    }


}
