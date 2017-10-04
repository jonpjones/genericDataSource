//
//  Items.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/21/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

struct ItemA {
    let title: String
    let subtitle: String
    
    func convertToViewModel() -> ItemCellViewModelA {
        return ItemCellViewModelA(item: self)
    }
}

struct ItemB {
    let title: String
    let image: UIImage?
    
    func convertToViewModel() -> ItemCellViewModelB {
        return ItemCellViewModelB(item: self)
    }
}

struct ItemC {
    let title: String
    let description: String
    
    func convertToViewModel() -> ItemCellViewModelC {
        return ItemCellViewModelC(item: self)
    }
}

struct Items {
    static var allA = [
        ItemA(title: "First A", subtitle: "Testing OneTwo"),
        ItemA(title: "Second A", subtitle: "Testing ThreeFour"),
        ItemA(title: "Third A", subtitle: "Testing FiveSix"),
        ItemA(title: "Fourth A", subtitle: "Testing SevenEight"),
        ItemA(title: "First A", subtitle: "Testing OneTwo"),
        ItemA(title: "Second A", subtitle: "Testing ThreeFour"),
        ItemA(title: "Third A", subtitle: "Testing FiveSix"),
        ItemA(title: "Fourth A", subtitle: "Testing SevenEight"),
        ItemA(title: "First A", subtitle: "Testing OneTwo"),
        ItemA(title: "Second A", subtitle: "Testing ThreeFour"),
        ItemA(title: "Third A", subtitle: "Testing FiveSix"),
        ItemA(title: "Fourth A", subtitle: "Testing SevenEight"),
        ItemA(title: "First A", subtitle: "Testing OneTwo"),
        ItemA(title: "Second A", subtitle: "Testing ThreeFour"),
        ItemA(title: "Third A", subtitle: "Testing FiveSix"),
        ItemA(title: "Fourth A", subtitle: "Testing SevenEight")
    ]
    
    static var allB = [
        ItemB(title: "First B", image: #imageLiteral(resourceName: "basketBall")),
        ItemB(title: "Second B", image: #imageLiteral(resourceName: "softball")),
        ItemB(title: "Third B", image: #imageLiteral(resourceName: "football")),
        ItemB(title: "Fourth B", image: #imageLiteral(resourceName: "volleyball"))
    ]
    
    static var allC = [
        ItemC(title: "First C", description: "Lorem ipsum and whatever else usually goes in the latin placeholder"),
        ItemC(title: "Second C", description: "Lorem ipsum and whatever else usually goes in the latin placeholder"),
        ItemC(title: "Third C", description: "Lorem ipsum and whatever else usually goes in the latin placeholder"),
        ItemC(title: "Fourth C", description: "Lorem ipsum and whatever else usually goes in the latin placeholder")
    ]
}


extension Array where Element == ItemA {
    func toViewModels() -> [ItemCellViewModelA] {
        return self.map({ (item) -> ItemCellViewModelA in
            return ItemCellViewModelA(item: item)
        })
    }
}

extension Array where Element == ItemB {
    func toViewModels() -> [ItemCellViewModelB] {
        return self.map({ (item) -> ItemCellViewModelB in
            return ItemCellViewModelB(item: item)
        })
    }
}

extension Array where Element == ItemC {
    func toViewModels() -> [ItemCellViewModelC] {
        return self.map({ (item) -> ItemCellViewModelC in
            return ItemCellViewModelC(item: item)
        })
    }
}






