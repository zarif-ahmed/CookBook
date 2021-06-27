//
//  NetworkRequest.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import Alamofire

final class NetworkRequest: Request {
    
    let method      : HTTPMethod
    let endpoint    : String
    var headers     : HTTPHeaders // this is var because default headers like content-type and session will be appended to the same array
    let parameters  : Parameters
    let encoding    : ParameterEncoding?
    
    init(method     : HTTPMethod,
         endpoint   : String,
         headers    : HTTPHeaders = [],
         parameters : Parameters = [:],
         encoding   : ParameterEncoding? = nil) {
        self.method       = method
        self.endpoint     = endpoint
        self.headers      = headers
        self.parameters   = parameters
        self.encoding     = encoding
    }
}
