//
//  NetworkError.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import Foundation

struct NetworkError: Error {
    
    let domain     : NetworkErrorDomain
    let type       : NetworkErrorType
    let statusCode : Int
    let message    : String?
    let content    : Data?

    init(domain: NetworkErrorDomain, type: NetworkErrorType, statusCode : Int, message: String? = nil, contents: Data? = nil) {
        self.domain     = domain
        self.type       = type
        self.statusCode = statusCode
        self.message    = message
        self.content    = contents
    }
}

struct APIError: Codable {
    let statusCode : String?
    let message    : String?
}
