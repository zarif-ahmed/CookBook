//
//  Constants.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import Foundation

enum Constants {
    
    // MARK: - File Extension
    enum FileExtension: String {
       case plist  = "plist"
       case JSON   = "json"
    }
    
    // MARK: - Build Settings & Config
    enum PlistKeys: String {
        case configDictionary = "CB_CONFIG"
        case serverURL        = "CB_SERVER_URL"
    }

    // These values would be set in the build settings as per the configurations [debug/release]
    enum BuildConfig {
        static let cbConfig   = Bundle.main.infoDictionary?[PlistKeys.configDictionary.rawValue] as? [String: Any]
        static let serverURL  = cbConfig?[PlistKeys.serverURL.rawValue] as? String ?? ""
    }
    
    enum Endpoints: String {
        case randomMeal = "/v1/1/random.php"
        case searchMeal = "/v1/1/search.php"
    }
}
