//
//  DataProvider.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/22/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation

typealias NibName = String
typealias ReuseID = String

protocol DataProvider {
    func getReuseIDsAndNibNames() -> [(ReuseID, NibName)]
    func numberofSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> ModelFormatting?
    func updateItem(at indexPath: IndexPath, value: ModelFormatting)
    func insertItem(value: ModelFormatting, at: IndexPath)
    func removeItem(at: IndexPath)
}
