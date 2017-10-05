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

protocol CellType: ModelFormatting {
    associatedtype Cell: UICollectionViewCell, CellConfigurable
    associatedtype Item
    var item: Item { get }
    var didSelect: ((Item) -> ())? { get set }
}

extension CellType where Cell.T == Self {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(Cell.self)", for: indexPath) as? Cell else {
            fatalError("Casting error: \(#function)")
        }
        return populate(configurable: cell)
    }
    
    var nibName: String {
        return String(describing: type(of: Cell.self)).components(separatedBy: ".").first!
    }
    
    var reuseIdentifier: String {
        return String(describing: type(of: Cell.self)).components(separatedBy: ".").first!
    }
    var cellSize: CGSize {
        return Cell.cellSize
    }
}
