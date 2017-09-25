//
//  ArrayDataSource.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/22/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

class ArrayDataSource<T, Cell>: CollectionViewDataSource<CollectionViewDataProvider<T>, Cell> where
    Cell: UICollectionViewCell,
    Cell: CellConfigurable,
    Cell.T == T {
    
    convenience init(from array: [T], collectionView: UICollectionView) {
        self.init(from: [array], collectionView: collectionView)
    }
    
    init(from array: [[T]], collectionView: UICollectionView) {
        let dataProvider = CollectionViewDataProvider(items: array)
        super.init(provider: dataProvider, collectionView: collectionView)
    }
}
