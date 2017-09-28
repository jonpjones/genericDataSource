//
//  CollectionViewDataSource.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/21/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

//Data Source Abstraction

class CollectionViewDataSource<Provider, Cell>: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout where
    Provider: DataProvider,
    Cell: CellConfigurable,
    Cell: UICollectionViewCell,
    Provider.T == Cell.T
{
    private let dataProvider: Provider
    private let collectionView: UICollectionView
    private var didSelect: ((Provider.T) -> ()) = { _ in }
    
    public var animatesChanges: Bool = true
    
    init(provider: Provider, collectionView: UICollectionView, didSelect: ((Provider.T) -> ())? = nil) {
        self.dataProvider = provider
        self.collectionView = collectionView
        
        if let selection = didSelect {
            self.didSelect = selection
        }
        super.init()
        registerCells()
    }
    
    func registerCells() {
        let nib = UINib(nibName: Cell.nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: Cell.cellReuseIdentifier)
    }
    
    func assignAsDatasource() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.cellReuseIdentifier, for: indexPath) as? Cell,
            let item = dataProvider.item(at: indexPath)
            else {
                fatalError("Could Not Dequeue Cell or get item from provider")
        }
        
        if let selectedIndexPaths = collectionView.indexPathsForSelectedItems {
            cell.isSelected = selectedIndexPaths.contains(indexPath)
        }
        
        cell.config(item, at: indexPath)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataProvider.numberofSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Cell.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataProvider.item(at: indexPath) {
            self.didSelect(item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("deselected item")
    }
    
    //MARK: Functions for DataSource
    func removeItems(at indexPaths: [IndexPath]) {
        indexPaths.forEach { (indexPath) in
            dataProvider.removeItem(at: indexPath)
        }
        self.animatesChanges ? collectionView.deleteItems(at: indexPaths) : collectionView.reloadData()
    }
    
    func insertItem(value: Provider.T, at indexPath: IndexPath) {
        dataProvider.insertItem(value: value, at: indexPath)
        collectionView.insertItems(at: [indexPath])
        self.animatesChanges ? collectionView.insertItems(at: [indexPath]) : collectionView.reloadData()
    }
    
    func appendItem(value: Provider.T, in section: Int) {
        let appendedIndex = dataProvider.numberOfItems(in: section)
        let newIndexPath = IndexPath(row: appendedIndex, section: section)
        insertItem(value: value, at: newIndexPath)
    }
}

class CollectionViewDataProvider<T>: DataProvider {
    var items: [[T]]
    
    init(items: [[T]]) {
        self.items = items
    }
    
    func numberofSections() -> Int {
        return items.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        let sectionItems = items[section]
        return sectionItems.count
    }
    
    func item(at indexPath: IndexPath) -> T? {
        guard indexPath.section >= 0, indexPath.section < items.count else { return nil }
        let sectionItems = items[indexPath.section]
        guard indexPath.row >= 0, indexPath.row < sectionItems.count else { return nil }
        return sectionItems[indexPath.row]
    }
    
    func updateItem(at indexPath: IndexPath, value: T) {
        items[indexPath.section][indexPath.row] = value
    }
    
    func insertItem(value: T, at indexPath: IndexPath) {
        switch indexPath.section {
        case items.count:
            items.append([value])
        case (0...items.count - 1):
            var itemSection = items[indexPath.section]
            itemSection.insert(value, at: indexPath.row)
            items[indexPath.section] = itemSection
        default:
            fatalError("Unreachable IndexPath. ")
        }
    }
    
    func removeItem(at indexPath: IndexPath) {
        guard indexPath.section < items.count else { return }
        var itemSection = items[indexPath.section]
        itemSection.remove(at: indexPath.row)
        items[indexPath.section] = itemSection
    }
}
