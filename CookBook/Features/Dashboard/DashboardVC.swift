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

    @IBOutlet private weak var searchTextfield: UITextField!
    @IBOutlet private weak var mealsTableView: UITableView!
    
    private var type: MealsTableType = .random
    
    private let apiDatasource = CookBookDatasource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiDatasource.getRandomMeal()
        
        apiDatasource.searchMeal(with: "piz")
    }
}

extension DashboardVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
