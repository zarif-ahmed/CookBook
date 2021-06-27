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
    
    private var gradient: CAGradientLayer?
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addGradient()
    }
    
    @IBAction private func likeAction(_ sender: Any) {
        didPressLikeButton?()
    }
    
    private func updateUI() {
        titleLabel.text = model?.title
        
        mealImageView.setImage(with: model?.imageURL)
        
        updateLikeUI()
    }
    
    private func addGradient() {
        removeGradient()
        
        gradient         = CAGradientLayer()
        gradient?.frame  = bounds
        let startColor   = UIColor(white: 1, alpha: 0).cgColor
        let endColor     = UIColor(white: 0, alpha: 0.5).cgColor
        gradient?.colors = [startColor, endColor]
        
        if let gradientLayer = gradient {
            mealImageView.layer.addSublayer(gradientLayer)
        }
    }
    
    private func updateLikeUI() {
        let isLiked = model?.isLiked == true
        let title   = isLiked ? "Liked" : "Like"
        
        likeButton.backgroundColor = isLiked ? .red : .lightGray
            
        likeButton.setTitle(title, for: .normal)
    }
    
    private func clearUI() {
        titleLabel.text     = ""
        mealImageView.image = nil
        
        removeGradient()
    }
    
    private func removeGradient() {
        gradient?.removeFromSuperlayer()
        gradient = nil
    }
}
