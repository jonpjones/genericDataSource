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
        dataSourceA = ArrayDataSource(from: flatArrayOfViewModels, collectionView: collectionView, layoutHelper: .verticalStandard)
        dataSourceA?.assignAsDatasource(to: collectionView)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let itemB = ItemB(title: "New Sport", image: #imageLiteral(resourceName: "basketBall"))
        let bViewModel = itemB.convertToViewModel()
        dataSourceA?.appendItem(value: bViewModel, in: 0)
    }
    
    @IBAction func removeButtonTapped(_ sender: UIButton) {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            dataSourceA?.removeItems(at: selectedItems)
        }
    }
    
    func getAllViewModels() -> [ModelFormatting] {
        let allAViewModels = Items.allA.toViewModels(self)
        let allBViewModels = Items.allB.toViewModels(self)
        let allCViewModels = Items.allC.toViewModels(self)
        let viewModelArrays: [[ModelFormatting]]  = [allAViewModels, allBViewModels, allCViewModels]
        let flatArrayOfModels: [ModelFormatting] = viewModelArrays.flatMap({ $0 })
        return flatArrayOfModels
    }
}

extension ViewController: VMHandlerA {
    func cellButtonTapped(_: ItemCellViewModelA) {
        print("tap received by view controller")
    }
    
    func cellSelectedFor(viewModel: ItemCellViewModelA) {
        print("selection received by view controller")
    }
}

extension ViewController: VMHandlerB {
    func cellSelectedFor(viewModel: ItemCellViewModelB) {
        print("selection received by view controller")
    }
}

extension ViewController: VMHandlerC {
    func cellSelectedFor(viewModel: ItemCellViewModelC) {
        print("selection received by view controller")
    }
}


