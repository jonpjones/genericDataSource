//
//  ItemBCellB.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 10/4/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation

protocol VMHandlerB {
    func cellSelectedFor(viewModel: ItemCellViewModelB)
}

class ItemCellViewModelB: CellViewModel {
    typealias Cell = CellB
    weak var cell: Cell?
    
    var delegate: VMHandlerB?
    var didSelect: ((ItemB) -> ()) = { _ in }
    var item: ItemB
    
    init(item: ItemB, delegate: VMHandlerB? = nil) {
        self.item = item
        self.delegate = delegate
        self.didSelect = selectionClosure()
    }
    
    func selectionClosure() -> ((Item) -> ()) {
        return { [weak self] item in
            if let weakSelf = self {
                weakSelf.updateItemTitle()
                weakSelf.cell?.config(weakSelf)
                weakSelf.delegate?.cellSelectedFor(viewModel: weakSelf)
            }
        }
    }
    
    private func updateItemTitle() {
        self.item.title = "SELECTED V2"
    }
}
