//
//  NetworkConstants.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import Foundation

// Common header values for network request
enum NetworkMimeType: String {
    case html             = "text/html"
    case json             = "application/json"
    case binaryData       = "application/x-www-form-urlencoded"
    case applicationXHtml = "application/xhtml+xml;charset=UTF-8"
}

// Common headers used across network request
enum NetworkHeader: String {
    case accept             = "Accept"
    case acceptEncoding     = "Accept-Encoding"
    case authorization      = "Authorization"
    case cookie             = "Cookie"
    case contentType        = "Content-Type"
    case userAgent          = "User-Agent"
    case bearer             = "Bearer"
    case refreshToken
}

// Common error types for ease of handling
enum NetworkErrorType {
    case badRequest
    case unauthorized
    case forbidden
    case internalServerError
    case noInternet
    case connectivityIssue
    case requestTimedOut
    case invalidURL
    case validationFailed
    case decodeJSONFailed
    case invalidNetworkRequest
    case invalidMockRequest
    case other
    
    var code: Int {
        switch self {
        case .badRequest:
            return 400
        case .unauthorized:
            return 401
        case .forbidden:
            return 403
        case .internalServerError:
            return 500
        case .noInternet:
            return 10001
        case .connectivityIssue:
            return 10002
        case .requestTimedOut:
            return 10003
        case .invalidURL:
            return 10004
        case .validationFailed:
            return 10005
        case .decodeJSONFailed:
            return 10006
        case .invalidNetworkRequest:
            return 10007
        case .invalidMockRequest:
            return 10008
        case .other:
            return 10009
        }
    }
}

// to differentiate between client-side/server-side error
enum NetworkErrorDomain {
    case client
    case server
}
