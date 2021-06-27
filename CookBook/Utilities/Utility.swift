//
//  Utility.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import Foundation

// Use this method to print statements when in debug mode
func debugLog(message: String) {
    #if DEBUG
    print("\n*******************\n\(message)\n*******************\n")
    #endif
}
