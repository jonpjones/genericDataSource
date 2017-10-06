//
//  ItemBCellB.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 10/4/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

class ItemCellViewModelB: CellViewModel {
    typealias Cell = CellB
    
    var didSelect: ((ItemB) -> ())?
    var item: ItemB
    
    init(item: ItemB) {
        self.item = item
    }
}
