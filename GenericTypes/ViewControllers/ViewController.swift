//
//  ViewController.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/20/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    var dataSourceA: ArrayDataSource?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flatArrayOfViewModels = getAllViewModels()
        dataSourceA = ArrayDataSource(from: flatArrayOfViewModels, collectionView: collectionView, layoutHelper: .horizontalStandard)
        dataSourceA?.assignAsDatasource(to: collectionView)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let itemB = ItemB(title: "New Sport", image: #imageLiteral(resourceName: "basketBall"))
        let bViewModel = itemB.convertToViewModel()
        bViewModel.didSelect = bClosure()
        dataSourceA?.appendItem(value: bViewModel, in: 0)
    }
    
    @IBAction func removeButtonTapped(_ sender: UIButton) {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            dataSourceA?.removeItems(at: selectedItems)
        }
    }
    
    func getAllViewModels() -> [ModelFormatting] {
        let allAViewModels = Items.allA.toViewModels()
        allAViewModels.forEach { (viewModel) in
            viewModel.didSelect = self.aClosure()
        }
        
        let allBViewModels = Items.allB.toViewModels()
        allBViewModels.forEach { (viewModel) in
            viewModel.didSelect = self.bClosure()
        }
        
        let allCViewModels = Items.allC.toViewModels()
        allCViewModels.forEach { (viewModel) in
            viewModel.didSelect = self.cClosure()
        }
        
        let viewModelArrays: [[ModelFormatting]]  = [allAViewModels, allBViewModels, allCViewModels]
        let flatArrayOfModels: [ModelFormatting] = viewModelArrays.flatMap({ $0 })
        return flatArrayOfModels
    }
    
    func aClosure() -> (ItemA) -> () {
        let itemASelect: ((ItemA) -> ()) = { itemC in
            print("item A got selected!")
        }
        return itemASelect
    }
    
    func bClosure() -> (ItemB) -> () {
        let itemBSelect: ((ItemB) -> ()) = { itemC in
            print("item B got selected!")
        }
        return itemBSelect
    }
    func cClosure() -> (ItemC) -> () {
        let itemCSelect: ((ItemC) -> ()) = { itemC in
            print("item C got selected!")
        }
        return itemCSelect
    }
}


