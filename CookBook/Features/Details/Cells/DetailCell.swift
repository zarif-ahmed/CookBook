//
//  DetailCell.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import UIKit

final class DetailCell: UITableViewCell, NibLoadableView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var model: MealDetailsVC.Model? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clearUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        clearUI()
    }
    
    private func clearUI() {
        titleLabel.text       = ""
        descriptionLabel.text = ""
    }

    func updateUI() {
        titleLabel.text       = model?.title
        descriptionLabel.text = model?.description
    }
}
