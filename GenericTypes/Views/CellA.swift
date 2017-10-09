//
//  CellA.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/25/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import UIKit

class CellA: UICollectionViewCell, CellConfigurable {
    static var cellSize: CGSize = CGSize(width: 180, height: 100)
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? .lightGray : .darkGray
        }
    }
    @IBOutlet var button: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    weak var viewModel: ItemCellViewModelA?
    
    func config(_ viewModel: ItemCellViewModelA) {
        self.viewModel = viewModel
        viewModel.cell = self
        titleLabel.text = viewModel.item.title
        subtitleLabel.text = viewModel.item.subtitle
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        viewModel?.tappedPrimaryButton()
    }
}
