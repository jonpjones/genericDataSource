//
//  ItemBCellB.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 10/4/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

class ItemCellViewModelB: CellType {
    typealias Cell = CellB
    
    var didSelect: ((ItemB) -> ())?
    let item: ItemB
    
    init(item: ItemB) {
        self.item = item
    }
    
    func didSelectWith(indexPath: IndexPath) {
        if let itemSelection = didSelect {
            itemSelection(item)
        }
    }
}
