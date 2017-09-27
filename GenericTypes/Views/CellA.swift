//
//  CellA.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/25/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import UIKit

class CellA: NibDefinedCell, CellConfigurable {
    static var cellSize: CGSize {
        return  CGSize(width: 180, height: 100)
    }

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    func config(_ item: ItemA, at indexPath: IndexPath) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
}
