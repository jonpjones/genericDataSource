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
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

extension ModelFormatting {
    func populate<C>(configurable: C) -> C where C: CellConfigurable, C.T == Self {
        configurable.config(self)
        return configurable
    }
}

protocol CellType: ModelFormatting {
    associatedtype Cell: UICollectionViewCell, CellConfigurable
    
}

extension CellType where Cell.T == Self {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(Cell.self)", for: indexPath) as? Cell else {
            fatalError("Casting error: \(#function)")
        }
        return populate(configurable: cell)
    }
}
