//
//  ItemACellA.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 10/4/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

class ItemCellViewModelA: CellViewModel {
    typealias Cell = CellA
    
    var didSelect: ((ItemA) -> ())?
    var item: ItemA
    
    init(item: ItemA) {
        self.item = item
    }
}
