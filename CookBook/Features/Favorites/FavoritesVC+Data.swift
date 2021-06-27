//
//  FavoritesVC+Data.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import Foundation
import RealmSwift

extension FavoritesVC {
    
    func loadFavorites() {
        do {
            let realm     = try Realm()
            let favorites = realm.objects(MealModel.self).filter({ $0.isLiked })
            
            meals         = Array(favorites)
            
            reloadUI()
        } catch { }
        
    }
    
    func updateLikeStatus(index: Int) {
        let selectedMeal = meals[index]
        selectedMeal.toggleLikeStatus()
            .done { _ in }
            .catch { _ in }
            .finally { [weak self] in
                self?.reloadUI()
            }
    }
}
