//
//  DataProvider.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/22/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation

protocol DataProvider {
    associatedtype T
    func numberofSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> T?
    func updateItem(at indexPath: IndexPath, value: T)
}
