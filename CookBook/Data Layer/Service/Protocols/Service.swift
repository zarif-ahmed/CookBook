//
//  Service.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import PromiseKit

protocol Service {
    func task(request: Request) -> Promise<NetworkResponse>
}
