//
//  NetworkService.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import Alamofire
import PromiseKit

final class NetworkService: Service {
        
    // Communicates with alamofire to perform the network request and returns a NetworkResponse
    func task(request: Request) -> Promise<NetworkResponse> {
        let (promise, resolver) = Promise<NetworkResponse>.pending()
        
        // ensure request is of type NetworkRequest
        guard var networkRequest = request as? NetworkRequest else {
           resolver.reject(type: .invalidNetworkRequest)
           return promise
        }
    
        // check for network connectivity
        guard NetworkUtility.isNetworkReachable else {
            resolver.reject(type: .noInternet)
            return promise
        }
        
        // check for the base url
        guard let baseURL = URL(string: Constants.BuildConfig.serverURL) else {
            resolver.reject(type: .invalidURL)
            return promise
        }
        
        networkRequest = addRequiredHeaders(request: networkRequest)
        
        // build alamofire request from network request
        let afRequest = alamofireRequest(request: networkRequest, baseURL: baseURL)
        afRequest.validate().responseJSON(queue: NetworkUtility.backgroundQueue) { [weak self] serverResponse in
            
            debugLog(message: "\(serverResponse.debugDescription)")
            
            guard let self = self else {
                resolver.reject(domain: .client, type: .other)
                return
            }
            
            switch serverResponse.result {
            case .success:
                let response = self.parseNetworkResponse(data: serverResponse.data, response: serverResponse.response)
                resolver.fulfill(response)
            case .failure(let error):
                let error = self.parseNetworkError(error: error, data: serverResponse.data)
                resolver.reject(error)
            }
        }
        
        return promise
    }
    
    func cleanAllData() {
        // clear session details
    }
    
    private func addRequiredHeaders(request: NetworkRequest) -> NetworkRequest {
        // Default headers. Will be added to all request.
        request.headers.add(name: NetworkHeader.contentType.rawValue, value: NetworkMimeType.json.rawValue)
        request.headers.add(name: NetworkHeader.accept.rawValue, value: NetworkMimeType.json.rawValue)
        
        return request
    }
    
    // Builds an alamofire data request with the NetworkRequest passed
    private func alamofireRequest(request: NetworkRequest, baseURL: URL) -> DataRequest {
        let completeURL = baseURL.appendingPathComponent(request.endpoint)
        
        let encoding: ParameterEncoding
        switch request.method {
        case .get, .delete:
            encoding = URLEncoding.default
        default:
            encoding = JSONEncoding.prettyPrinted
        }
        
        return AF.request(completeURL,
                          method     : request.method,
                          parameters : request.parameters,
                          encoding   : request.encoding ?? encoding,
                          headers    : request.headers)
    }
    
    // Parse the alamofire response and map to NetworkResponse
    private func parseNetworkResponse(data: Data?, response: HTTPURLResponse?) -> NetworkResponse {
        let response = NetworkResponse(statusCode   : response?.statusCode,
                                       data         : data,
                                       response     : response)
        return response
    }
    
    // Parse the alamofire error and map to NetworkError
    private func parseNetworkError(error: AFError, data: Data?) -> NetworkError {
        let errorType = mapNetworkErrorType(error: error)
        
        let error     = NetworkError(domain     : .server,
                                     type       : errorType,
                                     statusCode : errorType.code,
                                     message    : error.localizedDescription,
                                     contents   : data)
        
        return error
    }
    
    // map alamofire error to one of the NetworkErrorType
    private func mapNetworkErrorType(error: AFError) -> NetworkErrorType {
        guard let statusCode = error.responseCode else {
            return .other
        }
        
        let kind: NetworkErrorType
        switch statusCode {
        case NetworkErrorType.badRequest.code:
            kind = .badRequest
        case NetworkErrorType.unauthorized.code:
            kind = .unauthorized
        case NetworkErrorType.forbidden.code:
            kind = .forbidden
        case NetworkErrorType.internalServerError.code:
            kind = .internalServerError
        case NSURLErrorNotConnectedToInternet:
            kind = .noInternet
        case NSURLErrorBadURL, NSURLErrorUnsupportedURL:
            kind = .invalidURL
        case NSURLErrorTimedOut:
            kind = .requestTimedOut
        case NSURLErrorAppTransportSecurityRequiresSecureConnection,
                 NSURLErrorCannotFindHost,
                 NSURLErrorCannotConnectToHost,
                 NSURLErrorNetworkConnectionLost,
                 NSURLErrorDNSLookupFailed,
                 NSURLErrorResourceUnavailable:
            kind = .connectivityIssue
        default:
            kind = .other
        }
        
        return kind
    }
}
