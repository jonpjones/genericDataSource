//
//  ArrayDataSource.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/22/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

class ArrayDataSource: CollectionViewDataSource {
    
    convenience init(from array: [ModelFormatting], collectionView: UICollectionView, layoutHelper: CVLayoutHelper = .verticalStandard, didSelect: ((ModelFormatting) -> ())? = nil) {
        self.init(from: [array], collectionView: collectionView, layoutHelper: layoutHelper, didSelect: didSelect)
    }
    
    init(from array: [[ModelFormatting]], collectionView: UICollectionView, layoutHelper: CVLayoutHelper, didSelect: ((ModelFormatting) -> ())? = nil) {
        let dataProvider = CollectionViewDataProvider(items: array)
        super.init(provider: dataProvider, collectionView: collectionView, didSelect: didSelect, layoutHelper: layoutHelper)
    }
}
