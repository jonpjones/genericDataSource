//
//  BasicCVLayout.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/26/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

enum CVLayoutHelper {
    case verticalStandard
    case vertical(with: VerticalDimension)
    
    case horizontalStandard
    case horizontal(with: HorizontalDimension)

    var direction: UICollectionViewScrollDirection {
        switch self {
        case .verticalStandard, .vertical(_):
            return .vertical
        case .horizontalStandard, .horizontal(_):
            return .horizontal
        }
    }
    
    var sideDimension: CGFloat? {
        switch self {
        case .verticalStandard, .horizontalStandard:
            return nil
        case .horizontal(let layout):
            return layout.cellWidth
        case .vertical(let layout):
            return layout.cellHeight
        }
    }
    
    var rowOrColumnCount: CGFloat? {
        switch self {
        case .vertical(let layout):
            return layout.numberOfColumns
        case .horizontal(let layout):
            return layout.numberOfRows
        case .horizontalStandard, .verticalStandard:
            return nil
        }
    }
    
    var interItemSpacing: CGFloat {
        let standard: CGFloat = 10
        switch self {
        case .verticalStandard, .horizontalStandard:
            break
        case .vertical(let layout):
            return layout.interItemSpacing
        case .horizontal(let layout):
            return layout.interItemSpacing
        }
        return standard
    }
    var lineSpacing: CGFloat {
        let standard: CGFloat = 10
        switch self {
        case .verticalStandard, .horizontalStandard:
            break
        case .vertical(let layout):
            return layout.lineSpacing
        case .horizontal(let layout):
            return layout.lineSpacing
        }
        return standard
    }
    
    var selectable: Bool {
        switch self {
        case .verticalStandard, .horizontalStandard:
            return true
        case .vertical(let layout):
            return layout.selectable
        case .horizontal(let layout):
            return layout.selectable
        }
    }
}

struct HorizontalDimension {
    let cellWidth: CGFloat
    let numberOfRows: CGFloat
    var interItemSpacing: CGFloat
    var lineSpacing: CGFloat
    var selectable: Bool
    
    init(width: CGFloat, rowCount: CGFloat, itemSpacing: CGFloat = 10, lineSpacing: CGFloat = 10, selectable: Bool = true) {
        self.cellWidth = width
        self.numberOfRows = rowCount
        self.interItemSpacing = itemSpacing
        self.lineSpacing = lineSpacing
        self.selectable = selectable
    }
}

struct VerticalDimension {
    let cellHeight: CGFloat
    let numberOfColumns: CGFloat
    var interItemSpacing: CGFloat
    var lineSpacing: CGFloat
    var selectable: Bool
    
    init(height: CGFloat, colCount: CGFloat, itemSpacing: CGFloat = 10, lineSpacing: CGFloat = 10, selectable: Bool = true) {
        self.cellHeight = height
        self.numberOfColumns = colCount
        self.interItemSpacing = itemSpacing
        self.lineSpacing = lineSpacing
        self.selectable = selectable
    }
}
