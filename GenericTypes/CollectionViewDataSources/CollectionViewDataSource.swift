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
    private var collectionView: UICollectionView
    private var layoutHelper: CVLayoutHelper
    private var didSelect: ((Provider.T) -> ()) = { _ in }
    
    public var animatesChanges: Bool = true
    
    private lazy var cellDimension: CGSize = {
        guard
            let sideDimension = self.layoutHelper.sideDimension,
            let rowOrColumnCount = self.layoutHelper.rowOrColumnCount
        else {
            return Cell.cellSize
        }
        let height = self.getCellHeight(helperCount: rowOrColumnCount, dimensionSize: sideDimension)
        let width = self.getCellWidth(helperCount: rowOrColumnCount, dimensionSize: sideDimension)
        return CGSize(width: width, height: height)
    }()
    
    init(provider: Provider, collectionView: UICollectionView, didSelect: ((Provider.T) -> ())? = nil, layoutHelper: CVLayoutHelper) {
        self.dataProvider = provider
        self.collectionView = collectionView
        self.layoutHelper = layoutHelper
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
    
    func assignAsDatasource(to collectionView: UICollectionView) {
        self.collectionView = collectionView
        assignScrollDirection()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.collectionView.reloadData()
    }
    
    func assignScrollDirection() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = layoutHelper.direction
        }
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
        
        cell.config(item)
        return cell
    }
    
    private func getCellHeight(helperCount: CGFloat, dimensionSize: CGFloat) -> CGFloat {
        if layoutHelper.direction == .vertical {
            return layoutHelper.sideDimension ?? Cell.cellSize.height
        } else {
            return getItemSizeForSpacing(cvContentDimension: self.collectionView.frame.height, spacingCount: helperCount)
        }
    }
    
    private func getCellWidth(helperCount: CGFloat, dimensionSize: CGFloat) -> CGFloat {
        if layoutHelper.direction == .horizontal {
            return layoutHelper.sideDimension ?? Cell.cellSize.width
        } else {
            return getItemSizeForSpacing(cvContentDimension: self.collectionView.frame.width, spacingCount: helperCount)
        }
    }
    
    private func getItemSizeForSpacing(cvContentDimension: CGFloat, spacingCount: CGFloat) -> CGFloat {
        let totalSpacing = (self.layoutHelper.lineSpacing) * spacingCount.rounded()
        let usableContentSize = cvContentDimension - totalSpacing
        return usableContentSize / spacingCount
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataProvider.numberofSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellDimension
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataProvider.item(at: indexPath) {
            self.didSelect(item)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return layoutHelper.interItemSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return layoutHelper.lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("deselected item")
    }
    
    //MARK: Functions for DataSource Changes
    func removeItems(at indexPaths: [IndexPath]) {
        indexPaths.forEach { (indexPath) in
            dataProvider.removeItem(at: indexPath)
        }
        self.animatesChanges ? collectionView.deleteItems(at: indexPaths) : collectionView.reloadData()
    }
    
    func insertItem(value: Provider.T, at indexPath: IndexPath) {
        dataProvider.insertItem(value: value, at: indexPath)
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


class DBCollection: Collection {
    func index(after i: Int) -> Int {
        return objects.index(after: i)
    }
    
    var objects: [ItemA]
    
    var startIndex: Int {
        return objects.startIndex
    }
    
    var endIndex: Int {
        return objects.endIndex
    }
    
    subscript(position: Int) -> ItemA {
        precondition(indices.contains(position), "Out of bounds")
        return objects[position]
    }
    
    init(with items: [ItemA]) {
        self.objects = items
    }
}
