//
//  BasicCVLayout.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/26/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

enum ScrollDirection {
    case vertical
    case horizontal
}

protocol CVLayout {
    var insets: UIEdgeInsets { get }
    var selectable: Bool { get }
    var highlights: Bool { get }
}
extension CVLayout {
    var insets: UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    var selectable: Bool {
        return true
    }
    
    var highlights: Bool {
        return true
    }
}

struct HorizontalCVLayout: CVLayout {
    let cellWidth: CGFloat
    let numberOfRows: Int
}

struct VerticalCVLayout: CVLayout {
    let cellHeight: CGFloat
    let numberOfColumns: Int
}
