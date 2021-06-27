//
//  DashboardVC+Data.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import Foundation
import RealmSwift

extension DashboardVC {
    
    func loadRandomDish() {
        apiDatasource.getRandomMeal()
            .done { [weak self] randomMeal in
                guard let meal = randomMeal else {
                    return
                }
                
                self?.randomMeal = meal
                self?.meals      = [meal]
            }
            .catch { [weak self] error in
                self?.parseNetworkError(error: error)
            }
    }
    
    func searchMeal(with text: String) {
        apiDatasource.searchMeal(with: text)
            .done { [weak self] meals in
                self?.meals = meals
            }
            .catch { [weak self] error in
                self?.parseNetworkError(error: error)
            }
    }
    
    func updateLikeStatus(for index: Int) {
        do {
            let selectedMeal = meals[index]
            let realm = try Realm()
            try realm.write {
                selectedMeal.isLiked.toggle()
                realm.add(selectedMeal, update: .all)
                
                reloadUI()
            }
        } catch { }
    }
    
    private func updateMealDatasource(with meals: [MealModel]) {
        self.meals = meals
    }
    
    private func parseNetworkError(error: Error) {
        guard let networkError = error as? NetworkError else {
            return
        }
        
        switch networkError.type {
        case .noInternet:
            showNoInternetAlert()
        default:
            showAlert(message: "We are unable to process your request at the moment. Please try again later.", firstActionTitle: "OK")
        }
    }
}
