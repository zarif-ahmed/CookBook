//
//  Storyboarded.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import UIKit

protocol Storyboarded where Self: UIViewController {
    
    static var storyboardIdentifier: String { get }
}

extension Storyboarded {
   
    static var storyboardIdentifier: String {
        String(describing: self)
    }
    
    static func instantiate(from board: String = "Main") -> Self {
        // load the storyboard passed
        let storyboard = UIStoryboard(name: board, bundle: Bundle.main)

        // instantiate the view controller with storyboardIdentifier
        guard let viewController = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("Couldn't instantiate view controller with identifier \(storyboardIdentifier)")
        }

        return viewController
    }
}
