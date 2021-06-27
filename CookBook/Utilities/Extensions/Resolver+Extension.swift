//
//  Resolver+Extension.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import PromiseKit

extension Resolver {
    
    func reject(domain: NetworkErrorDomain = .client, type: NetworkErrorType) {
        let error = NetworkError(domain: domain, type: type, statusCode: type.code)
        reject(error)
    }
}
