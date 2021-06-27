//
//  UIImageView+Extension.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import UIKit
import AlamofireImage

extension UIImageView {
    
    func setImage(with url: String?,
                  placeholder: UIImage? = UIImage(named: Constants.Assets.placeholder.rawValue)) {
        self.image = placeholder
        
        guard let urlString = url, let imageURL = URL(string: urlString) else {
            self.image = placeholder
            return
        }

        af.setImage(withURL: imageURL, placeholderImage: placeholder)
    }
}
