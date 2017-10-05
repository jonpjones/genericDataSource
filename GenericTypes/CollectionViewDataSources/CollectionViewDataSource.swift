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

class CollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let dataProvider: DataProvider
    private var collectionView: UICollectionView
    private var layoutHelper: CVLayoutHelper
    private var didSelect: ((ModelFormatting) -> ()) = { _ in }
    
    public var animatesChanges: Bool = true
    
    init(provider: DataProvider, collectionView: UICollectionView, didSelect: ((ModelFormatting) -> ())? = nil, layoutHelper: CVLayoutHelper) {
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
        let nameReusePairs = dataProvider.getReuseIDsAndNibNames()
        for (reuseID, nibName) in nameReusePairs {
            let nib = UINib(nibName: nibName, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: reuseID)
        }
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
        guard let viewModel = dataProvider.item(at: indexPath) else {
            print("No available cell!")
            return UICollectionViewCell()
        }
        return viewModel.collectionView(collectionView, cellForItemAt: indexPath)
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
        return dataProvider.item(at: indexPath)?.cellSize ?? CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataProvider.item(at: indexPath) {
            item.didSelectWith(indexPath: indexPath)
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
    
    func insertItem(value: ModelFormatting, at indexPath: IndexPath) {
        dataProvider.insertItem(value: value, at: indexPath)
        self.animatesChanges ? collectionView.insertItems(at: [indexPath]) : collectionView.reloadData()
    }
    
    func appendItem(value: ModelFormatting, in section: Int) {
        let appendedIndex = dataProvider.numberOfItems(in: section)
        let newIndexPath = IndexPath(row: appendedIndex, section: section)
        insertItem(value: value, at: newIndexPath)
    }
}

class CollectionViewDataProvider: DataProvider {
    var items: [[ModelFormatting]]
    
    init(items: [[ModelFormatting]]) {
        self.items = items
    }
    
    func numberofSections() -> Int {
        return items.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        let sectionItems = items[section]
        return sectionItems.count
    }
    
    func item(at indexPath: IndexPath) -> ModelFormatting? {
        guard indexPath.section >= 0, indexPath.section < items.count else { return nil }
        let sectionItems = items[indexPath.section]
        guard indexPath.row >= 0, indexPath.row < sectionItems.count else { return nil }
        return sectionItems[indexPath.row]
    }
    
    func updateItem(at indexPath: IndexPath, value: ModelFormatting) {
        items[indexPath.section][indexPath.row] = value
    }
    
    func insertItem(value: ModelFormatting, at indexPath: IndexPath) {
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
    
    func getReuseIDsAndNibNames() -> [(ReuseID, NibName)] {
        let tupleArray = items.flatMap { (arrayOfModelFormat) -> [(ReuseID, NibName)] in
            arrayOfModelFormat.map({ ($0.reuseIdentifier, $0.nibName) })
        }
        return tupleArray
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
