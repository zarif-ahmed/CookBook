//
//  NetworkHelpers.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import Alamofire

final class NetworkUtility {
    
    static let backgroundQueue = DispatchQueue(label: "sa.background.queue",
                                               qos: .background,
                                               attributes: .concurrent)
    
    // Returns the status of network connectivity
    class var isNetworkReachable: Bool {
       NetworkReachabilityManager()?.isReachable ?? false
    }

    class func decodeJSON<T: Codable>(type: T.Type, from data: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            let payload = try decoder.decode(T.self, from: data)

            return payload
        } catch {
            debugLog(message: "Failed to decode JSON for: \(T.self)")
            throw error
        }
    }

    class func encodeJSON<T: Encodable>(type: T) throws -> [String: Any]? {
        do {
            let encoder = JSONEncoder()
            let data    = try encoder.encode(type)

            return dictionaryFromData(data)
        } catch {
            throw error
        }
    }

    class func dictionaryFromData(_ data: Data) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            debugLog(message: "Failed to JSON serialize the data")
            return nil
        }
    }
}
