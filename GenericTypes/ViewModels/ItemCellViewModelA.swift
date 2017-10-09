//
//  ItemACellA.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 10/4/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

protocol VMHandlerA {
    func cellSelectedFor(viewModel: ItemCellViewModelA)
    func cellButtonTapped(_: ItemCellViewModelA)
}

class ItemCellViewModelA: CellViewModel {
    typealias Cell = CellA
    weak var cell: Cell?
    var delegate: VMHandlerA?
    
    var didSelect: ((ItemA) -> ()) = { _ in }
    var item: ItemA
    
    init(item: ItemA, delegate: VMHandlerA? = nil) {
        self.item = item
        self.delegate = delegate
        self.didSelect = selectionClosure()
    }
    
    func tappedPrimaryButton() {
        self.updateItemTitle()
        delegate?.cellButtonTapped(self)
        cell?.config(self)
    }
    
    func selectionClosure() -> ((Item) -> ()) {
        return { [weak self] item in
             if let weakSelf = self {
                weakSelf.updateItemSubtitle()
                weakSelf.delegate?.cellSelectedFor(viewModel: weakSelf)
                weakSelf.cell?.config(weakSelf)
            }
        }
    }
    
    private func updateItemTitle() {
        self.item.title = "TAPPED"
    }
    
    private func updateItemSubtitle() {
        self.item.subtitle = "SELECTED"
    }
}
