//
//  CellB.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/25/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import UIKit

class CellB: UICollectionViewCell, CellConfigurable {
    static var cellSize: CGSize = CGSize(width: 320, height: 150)
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var sportImageView: UIImageView!
    weak var viewModel: ItemCellViewModelB?
    
    func config(_ viewModel: ItemCellViewModelB) {
        self.viewModel = viewModel
        viewModel.cell = self
        titleLabel.text = viewModel.item.title
        sportImageView.image = viewModel.item.image
    }
}
