//
//  MealDetailsVC.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import UIKit
import RealmSwift

final class MealDetailsVC: UIViewController, Storyboarded {
    
    struct Model {
        var title: String
        var description: String?
        
    }
    
    @IBOutlet private weak var backButton     : UIButton!
    @IBOutlet private weak var likeButton     : UIButton!
    @IBOutlet private weak var mealTitleLabel : UILabel!
    @IBOutlet private weak var mealImageView  : UIImageView!
    
    @IBOutlet private weak var mealTableView  : UITableView! {
        didSet {
            mealTableView.register(DetailCell.self)
            
            mealTableView.tableFooterView = UIView(frame: .zero)
        }
    }
    
    var mealModel: MealModel?
    
    private var datasource: [Model] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        datasource.removeAll()
        
        let category = Model(title: "Category", description: mealModel?.strCategory ?? "-")
        datasource.append(category)
        
        let area = Model(title: "Area", description: mealModel?.strArea ?? "-")
        datasource.append(area)
        
        let instructions = Model(title: "Instructions", description: mealModel?.strInstructions ?? "-")
        datasource.append(instructions)
        
        let tags = Model(title: "Tags", description: mealModel?.strTags ?? "-")
        datasource.append(tags)
        
        let youtube = Model(title: "Youtube", description: mealModel?.strYoutube ?? "-")
        datasource.append(youtube)
       
        mealTitleLabel.text = mealModel?.strMeal
        
        mealImageView.setImage(with: mealModel?.imagePreviewURL)
        updateLikeUI()
        
        DispatchQueue.main.async { [weak self] in
            self?.mealTableView.reloadData()
        }
    }
    
    @IBAction private  func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func likeAction(_ sender: Any) {
        updateLikeStatus()
    }
    
    private func updateLikeStatus() {
        guard let selectedMeal = mealModel else { return }
        selectedMeal.toggleLikeStatus()
            .done { _ in }
            .catch { _ in }
            .finally { [weak self] in
                self?.updateLikeUI()
            }
    }

    private func updateLikeUI() {
        let isLiked = mealModel?.isLiked == true
        let title   = isLiked ? "Liked" : "Like"
        
        likeButton.backgroundColor = isLiked ? .red : .lightGray
            
        likeButton.setTitle(title, for: .normal)
    }
}

extension MealDetailsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell   = tableView.dequeueReusableCell(for: indexPath) as DetailCell
        cell.model = datasource[indexPath.row]
        return cell
    }
}
