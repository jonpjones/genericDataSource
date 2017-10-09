//
//  CellC.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/25/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import UIKit

class CellC: UICollectionViewCell, CellConfigurable {
    static var cellSize: CGSize = CGSize(width: 120, height: 150)
    
    @IBOutlet var latinTextView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    weak var viewModel: ItemCellViewModelC?
    
    func config(_ viewModel: ItemCellViewModelC) {
        self.viewModel = viewModel
        viewModel.cell = self
        self.titleLabel.text = viewModel.item.title
        self.latinTextView.text = viewModel.item.description
    }
}
