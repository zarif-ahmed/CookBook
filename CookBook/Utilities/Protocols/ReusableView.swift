//
//  ReusableView.swift
//  CookBook
//
//  Created by Zarif Ahmed on 6/27/21.
//

import UIKit

protocol ReusableView where Self: UIView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
