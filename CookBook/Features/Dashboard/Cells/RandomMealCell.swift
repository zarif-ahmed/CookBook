//
//  RandomMealCell.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import UIKit

final class RandomMealCell: UITableViewCell, NibLoadableView {
    
    @IBOutlet private weak var mealImageView: UIImageView!
    @IBOutlet private weak var titleLabel   : UILabel!
    @IBOutlet private weak var likeButton   : UIButton!
    
    var model: MealCellModel? {
        didSet {
            updateUI()
        }
    }
    
    var didPressLikeButton: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        clearUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        clearUI()
    }
    
    @IBAction private func likeAction(_ sender: Any) {
        didPressLikeButton?()
    }
    
    private func updateUI() {
        titleLabel.text = model?.title
        
        mealImageView.setImage(with: model?.imageURL)
        
        updateLikeStatus()
    }
    
    private func updateLikeStatus() {
        let isLiked = model?.isLiked == true
        let title   = isLiked ? "Liked" : "Like"
        
        likeButton.backgroundColor = isLiked ? .red : .lightGray
            
        likeButton.setTitle(title, for: .normal)
    }
    
    private func clearUI() {
        titleLabel.text     = ""
        mealImageView.image = nil
    }
}
