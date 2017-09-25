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
}

protocol CellConfigurable: ReusableCell {
    associatedtype T
    func config(_ item: T, at indexPath: IndexPath)
}
