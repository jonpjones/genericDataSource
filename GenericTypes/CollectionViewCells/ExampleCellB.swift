//
//  ExampleCellB.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/21/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import UIKit

class ExampleCellB: UICollectionViewCell, CellConfigurable {
    static var cellSize: CGSize = CGSize(width: 320, height: 150)
    static var cellReuseIdentifier: String = "ExampleCellB"

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var sportImageView: UIImageView!

    func config(_ item: ItemB, at indexPath: IndexPath) {
        titleLabel.text = item.title
        sportImageView.image = item.image
    }
}
