//
//  ItemCCellC.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 10/4/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

class ItemCellViewModelC: CellType {
    typealias Cell = CellC
    let item: ItemC
    
    init(item: ItemC) {
        self.item = item
    }
    
    func didSelectWith(indexPath: IndexPath) {
        if let itemSelection = item.didSelect {
            itemSelection(item)
        }
    }
}

