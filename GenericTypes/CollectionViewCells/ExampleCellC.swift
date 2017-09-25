//
//  ExampleCellC.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/21/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import UIKit

class ExampleCellC: UICollectionViewCell, CellConfigurable {
    static var cellSize: CGSize = CGSize(width: 120, height: 100)
    static var cellReuseIdentifier: String = "ExampleCellC"

    @IBOutlet var latinTextView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    
    func config(_ item: ItemC, at indexPath: IndexPath) {
        self.titleLabel.text = item.title
        self.latinTextView.text = item.description
    }
}
