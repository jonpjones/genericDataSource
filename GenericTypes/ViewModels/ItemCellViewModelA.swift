//
//  ItemACellA.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 10/4/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

class ItemCellViewModelA: CellType {
    typealias Cell = CellA
    
    var didSelect: ((ItemA) -> ())?
    let item: ItemA
    
    init(item: ItemA) {
        self.item = item
    }
    
    func didSelectWith(indexPath: IndexPath) {
        if let itemSelection = didSelect {
            itemSelection(item)
        }
    }
}
