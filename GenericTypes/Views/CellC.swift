//
//  CellC.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/25/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import UIKit

class CellC: NibDefinedCell, CellConfigurable {
    static var cellSize: CGSize = CGSize(width: 120, height: 150)
    
    @IBOutlet var latinTextView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    
    func config(_ item: ItemC, at indexPath: IndexPath) {
        self.titleLabel.text = item.title
        self.latinTextView.text = item.description
    }
}
