//
//  MealModel.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import Foundation
import RealmSwift
import PromiseKit

@objcMembers
final class MealModel: Object, Codable {
    dynamic var idMeal: String = ""
    dynamic var strMeal: String?
    dynamic var strDrinkAlternate: String?
    dynamic var strCategory: String?
    dynamic var strArea: String?
    dynamic var strInstructions: String?
    dynamic var strMealThumb: String?
    dynamic var strTags: String?
    dynamic var strYoutube: String?
    dynamic var strSource: String?
    dynamic var strImageSource: String?
    dynamic var strCreativeCommonsConfirmed: String?
    dynamic var dateModified: String?
    
    dynamic var imagePreviewURL: String = ""
    dynamic var isLiked: Bool = false
    
    override class func primaryKey() -> String? {
        "idMeal"
    }
    
    enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strDrinkAlternate
        case strCategory
        case strArea
        case strInstructions
        case strMealThumb
        case strTags
        case strYoutube
        case strSource
        case strImageSource
        case strCreativeCommonsConfirmed
        case dateModified
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        idMeal                      = try container.decodeIfPresent(String.self, forKey: .idMeal) ?? ""
        strMeal                     = try container.decodeIfPresent(String.self, forKey: .strMeal)
        strDrinkAlternate           = try container.decodeIfPresent(String.self, forKey: .strDrinkAlternate)
        strCategory                 = try container.decodeIfPresent(String.self, forKey: .strCategory)
        strArea                     = try container.decodeIfPresent(String.self, forKey: .strArea)
        strInstructions             = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        strMealThumb                = try container.decodeIfPresent(String.self, forKey: .strMealThumb)
        strTags                     = try container.decodeIfPresent(String.self, forKey: .strTags)
        strYoutube                  = try container.decodeIfPresent(String.self, forKey: .strYoutube)
        strSource                   = try container.decodeIfPresent(String.self, forKey: .strSource)
        strImageSource              = try container.decodeIfPresent(String.self, forKey: .strImageSource)
        strCreativeCommonsConfirmed = try container.decodeIfPresent(String.self, forKey: .strCreativeCommonsConfirmed)
        dateModified                = try container.decodeIfPresent(String.self, forKey: .dateModified)
        
        imagePreviewURL             = strMealThumb ?? "" + "/preview"
    }
    
    required init() {
        // do nothing
    }
    
    func toggleLikeStatus() -> Promise<Void> {
        let (promise, resolver) = Promise<Void>.pending()
        do {
            let realm = try Realm()
            try realm.write {
                isLiked.toggle()
                realm.add(self, update: .all)
                resolver.fulfill_()
            }
        } catch {
            resolver.fulfill_()
        }
        return promise
    }
}
