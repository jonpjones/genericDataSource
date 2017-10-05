//
//  ModelFormatting.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 10/4/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

protocol ModelFormatting {
    var nibName: String { get }
    var reuseIdentifier: String { get }
    var cellSize: CGSize { get }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func didSelectWith(indexPath: IndexPath)
}

extension ModelFormatting {
    func populate<C>(configurable: C) -> C where C: CellConfigurable, C.T == Self {
        configurable.config(self)
        return configurable
    }
    
    func didSelectWith(indexPath: IndexPath) {
        print("Item Selected at \(indexPath)")
    }
}


