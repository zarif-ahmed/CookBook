//
//  NibLoadableView.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import UIKit

// Conform all the tableview/collectionview cells to this protocol for ease of cell registration
protocol NibLoadableView where Self: UIView {
    static var nibName: String { get }
}

extension NibLoadableView {
    static var nibName: String {
        String(describing: self)
    }
}
