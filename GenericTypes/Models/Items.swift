//
//  Items.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/21/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

class ItemA {
    var title: String
    var subtitle: String

    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
    
    func convertToViewModel() -> ItemCellViewModelA {
        return ItemCellViewModelA(item: self)
    }
}

class ItemB {
    var title: String
    let image: UIImage?

    init(title: String, image: UIImage) {
        self.title = title
        self.image = image
    }
    
    func convertToViewModel() -> ItemCellViewModelB {
        return ItemCellViewModelB(item: self)
    }
}

class ItemC {
    var title: String
    var description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    func convertToViewModel() -> ItemCellViewModelC {
        return ItemCellViewModelC(item: self)
    }
}

extension Array where Element == ItemA {
    func toViewModels(_ delegate: VMHandlerA? = nil) -> [ItemCellViewModelA] {
        return self.map({ (item) -> ItemCellViewModelA in
            let vm = item.convertToViewModel()
            vm.delegate = delegate
            return vm
            
        })
    }
}

extension Array where Element == ItemB {
    func toViewModels(_ delegate: VMHandlerB? = nil) -> [ItemCellViewModelB] {
        return self.map({ (item) -> ItemCellViewModelB in
            let vm = item.convertToViewModel()
            vm.delegate = delegate
            return vm
            
        })
    }
}

extension Array where Element == ItemC {
    func toViewModels(_ delegate: VMHandlerC? = nil) -> [ItemCellViewModelC] {
        return self.map({ (item) -> ItemCellViewModelC in
            let vm = item.convertToViewModel()
            vm.delegate = delegate
            return vm
        })
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






