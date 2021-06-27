//
//  Datasource.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import Foundation

// Conform to this protocol to make API calls
protocol Datasource {

    var service: Service { get }
    
    // add logic(if required) to clear appropriate datasource data
    func cleanAllData()
}
