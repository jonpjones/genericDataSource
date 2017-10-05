//
//  CellViewModel.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 10/5/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

protocol CellViewModel: ModelFormatting {
    associatedtype Cell: UICollectionViewCell, CellConfigurable
    associatedtype Item
    var item: Item { get set }
    var didSelect: ((Item) -> ())? { get set }
    func didSelectWith(indexPath: IndexPath)
}

extension CellViewModel {
    func didSelectWith(indexPath: IndexPath) {
        if let itemSelection = didSelect {
            itemSelection(item)
        }
    }
}

extension CellViewModel where Cell.T == Self {
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
