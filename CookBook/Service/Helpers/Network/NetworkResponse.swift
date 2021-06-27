//
//  NetworkResponse.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import Foundation

struct NetworkResponse {
    
    let statusCode : Int?
    let data       : Data?
    let response   : HTTPURLResponse?

    init(statusCode: Int?, data: Data?, response: HTTPURLResponse?) {
        self.statusCode = statusCode
        self.data       = data
        self.response   = response
    }
}
