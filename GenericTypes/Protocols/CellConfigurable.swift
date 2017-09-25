//
//  CellConfigurable.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/21/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

public protocol ReusableCell {
    static var cellSize: CGSize { get }
    static var cellReuseIdentifier: String { get }
    static var nibName: String { get }
}

extension ReusableCell where Self: UICollectionViewCell {    
    static var nibName: String {
        return String(describing: type(of: self)).components(separatedBy: ".").first!
    }
    
    static var cellReuseIdentifier: String {
        return String(describing: type(of: self)).components(separatedBy: ".").first!
    }
}

protocol CellConfigurable: ReusableCell {
    associatedtype T
    func config(_ item: T, at indexPath: IndexPath)
}
