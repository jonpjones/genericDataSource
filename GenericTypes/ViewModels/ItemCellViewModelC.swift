//
//  ItemCCellC.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 10/4/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

protocol VMHandlerC {
    func cellSelectedFor(viewModel: ItemCellViewModelC)
}

class ItemCellViewModelC: CellViewModel {    
    typealias Cell = CellC
    weak var cell: Cell?
    
    var didSelect: ((ItemC) -> ()) = { _ in }
    var delegate: VMHandlerC?
    var item: ItemC
    
    init(item: ItemC, delegate: VMHandlerC? = nil) {
        self.item = item
        self.delegate = delegate
        self.didSelect = selectionClosure()
    }
    
    func selectionClosure() -> ((Item) -> ()) {
        return { [weak self] item in
            if let weakSelf = self {
                weakSelf.updateItemTitle()
                weakSelf.updateItemDescription()
                weakSelf.cell?.config(weakSelf)
                weakSelf.delegate?.cellSelectedFor(viewModel: weakSelf)
            }
        }
    }

    private func updateItemTitle() {
        self.item.title = "SELECTION 3"
    }
    
    private func updateItemDescription() {
        self.item.description = "WOW SELECTED AMAZING FANTASTIC"
    }
}

