//
//  ExampleCellA.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/21/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import UIKit

class ExampleCellA: UICollectionViewCell, CellConfigurable {
    static var cellSize: CGSize = CGSize(width: 180, height: 90)
    static var cellReuseIdentifier: String = "ExampleCellA"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    func config(_ item: ItemA, at indexPath: IndexPath) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
}

