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
    
    convenience init(from array: [T], collectionView: UICollectionView, layoutHelper: CVLayoutHelper = .verticalStandard, didSelect: ((T) -> ())? = nil) {
        self.init(from: [array], collectionView: collectionView, layoutHelper: layoutHelper, didSelect: didSelect)
    }
    
    init(from array: [[T]], collectionView: UICollectionView, layoutHelper: CVLayoutHelper, didSelect: ((T) -> ())? = nil) {
        let dataProvider = CollectionViewDataProvider(items: array)
        super.init(provider: dataProvider, collectionView: collectionView, didSelect: didSelect, layoutHelper: layoutHelper)
    }
}
