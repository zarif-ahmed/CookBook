//
//  DashboardVC.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import UIKit

enum MealsTableType {
    case random
    case search
}

final class DashboardVC: UIViewController {

    @IBOutlet private weak var searchTextfield: UITextField! {
        didSet {
            searchTextfield.delegate = self
        }
    }
    
    @IBOutlet private weak var mealsTableView: UITableView! {
        didSet {
            mealsTableView.register(SearchMealCell.self)
            mealsTableView.register(RandomMealCell.self)
            
            mealsTableView.tableFooterView = UIView(frame: .zero)
        }
    }
    
    var meals: [MealModel]   = [] {
        didSet {
            reloadUI()
        }
    }
    
    var randomMeal: MealModel?
    
    private var type: MealsTableType = .random
    let apiDatasource                = CookBookDatasource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        loadRandomDish()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadUI()
    }
    
    func reloadUI() {
        DispatchQueue.main.async { [weak self] in
            self?.mealsTableView.reloadData()
        }
    }
    
    private func setup() {
        searchTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapHandler() {
        searchHandler()
    }
    
    private func resetToRandomMealUI() {
        searchTextfield.text = ""
        type                 = .random
        
        if let random = randomMeal {
            meals = [random]
        } else {
            loadRandomDish()
        }
    }
    
    private func loadDetails(for meal: MealModel?) {
        guard let mealModel = meal else { return }
        
        let detailsVC       = MealDetailsVC.instantiate()
        detailsVC.mealModel = mealModel
        navigationController?.pushViewController(detailsVC,
                                                 animated: true)
    }
}

extension DashboardVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meal  = meals[indexPath.row]
        let model = MealCellModel(title: meal.strMeal,
                                  imageURL: meal.imagePreviewURL,
                                  isLiked: meal.isLiked)
        
        switch type {
        case .random:
            let cell   = tableView.dequeueReusableCell(for: indexPath) as RandomMealCell
            cell.model = model
            
            cell.didPressLikeButton = { [weak self] in
                self?.updateLikeStatus(for: indexPath.row)
            }
            
            return cell
        case .search:
            let cell   = tableView.dequeueReusableCell(for: indexPath) as SearchMealCell
            cell.model = model
            
            cell.didPressLikeButton = { [weak self] in
                self?.updateLikeStatus(for: indexPath.row)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch type {
        case .random:
            return 320
        case .search:
            return 160
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        meals.isEmpty ? 0 : 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame =  CGRect(x: 0,
                            y: 0,
                            width: tableView.bounds.size.width,
                            height: 50)
        
        let header = UILabel(frame: frame)
        header.font = .systemFont(ofSize: 24, weight: .bold)
        header.text = type == .random ? "DISH OF THE DAY:" : "SEARCH RESULTS:"
        header.textColor = .black
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = meals[indexPath.row]
        loadDetails(for: model)
    }
}

extension DashboardVC: UITextFieldDelegate {
    
    @objc func textDidChange() {
        if let searchText = searchTextfield.text, searchText.isEmpty {
            resetToRandomMealUI()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchHandler()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchHandler()
        return true
    }
    
    private func searchHandler() {
        view.endEditing(true)
        
        if let searchText = searchTextfield.text, !searchText.isEmpty {
            type = .search
            
            searchMeal(with: searchText)
        } else {
            resetToRandomMealUI()
        }
    }
}
