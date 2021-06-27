//
//  CookBookDatasource.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import RealmSwift
import PromiseKit

final class CookBookDatasource: Datasource {
    
    private(set) var service: Service
    
    init(service: Service = NetworkService()) {
        self.service = service
    }
    
    func cleanAllData() {
        // clean datasource
    }
}

extension CookBookDatasource {
    
    func getRandomMeal() -> Promise<MealModel?> {
        let (promise, resolver) = Promise<MealModel?>.pending()
        
        let request: Request
            request  = NetworkRequest(method: .get,
                                      endpoint: Constants.Endpoints.randomMeal.rawValue)

        service.task(request: request)
            .done(on: NetworkUtility.backgroundQueue) { [weak self] response in
                self?.parseRandomMealResponse(from: response, resolver: resolver)
            }
            .catch { error in
                resolver.reject(error)
            }
        
        return promise
    }
    
    private func parseRandomMealResponse(from response: NetworkResponse, resolver: Resolver<MealModel?>) {
        guard let data = response.data else {
            resolver.reject(type: .validationFailed)
            return
        }
        
        do {
            let payload   = try NetworkUtility.decodeJSON(type: MealAPI.self, from: data)
            let realm     = try Realm()
            let meal      = payload.meals.first
            let favorite  = realm.objects(MealModel.self).filter({ $0.isLiked && $0.idMeal == meal?.idMeal }).first
            
            if favorite != nil {
                meal?.isLiked = true
            }
            resolver.fulfill(meal)
        } catch {
            resolver.reject(type: .decodeJSONFailed)
        }
    }
}

extension CookBookDatasource {
    
    func searchMeal(with searchString: String) -> Promise<[MealModel]> {
        let (promise, resolver) = Promise<[MealModel]>.pending()
        
        let parameters = ["s": searchString]
        let request: Request
            request  = NetworkRequest(method: .get,
                                      endpoint: Constants.Endpoints.searchMeal.rawValue,
                                      parameters: parameters)

        service.task(request: request)
            .done(on: NetworkUtility.backgroundQueue) { [weak self] response in
                self?.parseSearchMealResponse(from: response, resolver: resolver)
            }
            .catch { error in
                resolver.reject(error)
            }
        
        return promise
    }
    
    private func parseSearchMealResponse(from response: NetworkResponse, resolver: Resolver<[MealModel]>) {
        guard let data = response.data else {
            resolver.reject(type: .validationFailed)
            return
        }
        
        do {
            let payload   = try NetworkUtility.decodeJSON(type: MealAPI.self, from: data)
            let realm     = try Realm()
            let favorites = realm.objects(MealModel.self).filter({ $0.isLiked })
            let meals     = payload.meals
            for meal in meals where favorites.contains(where: { $0.idMeal == meal.idMeal }) {
                meal.isLiked = true
            }
            resolver.fulfill(meals)
        } catch {
            resolver.reject(type: .decodeJSONFailed)
        }
    }
}
