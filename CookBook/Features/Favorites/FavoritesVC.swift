//
//  FavoritesVC.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import UIKit
import RealmSwift

final class FavoritesVC: UIViewController {
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var mealsTableView: UITableView! {
        didSet {
            self.mealsTableView.register(SearchMealCell.self)
            
            self.mealsTableView.tableFooterView = UIView(frame: .zero)
        }
    }
    
    var meals: [MealModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        loadFavorites()
    }
    
    @IBAction private  func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func reloadUI() {
        DispatchQueue.main.async { [weak self] in
            self?.mealsTableView.reloadData()
        }
    }
    
    private func loadDetailsVC(for meal: MealModel?) {
        guard let mealModel = meal else { return }
        
        let detailsVC       = MealDetailsVC.instantiate()
        detailsVC.mealModel = mealModel
        navigationController?.pushViewController(detailsVC,
                                                 animated: true)
    }
}

extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell   = tableView.dequeueReusableCell(for: indexPath) as SearchMealCell
        let meal   = meals[indexPath.row]
        let model  = MealCellModel(title: meal.strMeal,
                                   imageURL: meal.imagePreviewURL,
                                   isLiked: meal.isLiked)
        cell.model = model
        
        cell.didPressLikeButton = { [weak self] in
            self?.updateLikeStatus(index: indexPath.row)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = meals[indexPath.row]
        loadDetailsVC(for: model)
    }
}
