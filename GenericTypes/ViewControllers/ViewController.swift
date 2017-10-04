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

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var collectionView: UICollectionView!
    var dataSourceA: ArrayDataSource!
    var dataSourceB: ArrayDataSource!
    var dataSourceC: ArrayDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSourceA = ArrayDataSource(from: Items.allA.toViewModels(), collectionView: collectionView) { (item) in
            print("\(item)")
        }
        
        dataSourceB = ArrayDataSource(from: [Items.allB.toViewModels(), Items.allA.toViewModels(), Items.allC.toViewModels()], collectionView: collectionView, layoutHelper: .horizontalStandard)
       
        let layoutHelper = VerticalDimension(height: 150, colCount: 1)
        dataSourceC = ArrayDataSource(from: Items.allC.toViewModels(), collectionView: collectionView, layoutHelper: .vertical(with: layoutHelper))
        
        dataSourceA.assignAsDatasource(to: collectionView)
    }


    @IBAction func segmentedControlStateChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            dataSourceA.assignAsDatasource(to: collectionView)
        case 1:
            dataSourceB.assignAsDatasource(to: collectionView)
        case 2:
            dataSourceC.assignAsDatasource(to: collectionView)
        default:
            break
        }
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let itemA = ItemA(title: "A New String", subtitle: "With Crazy New Features")
            dataSourceA.appendItem(value: itemA.convertToViewModel(), in: 0)
        case 1:
            let itemB = ItemB(title: "New Sport", image: #imageLiteral(resourceName: "basketBall"))
            dataSourceB.appendItem(value: itemB.convertToViewModel(), in: 0)
        case 2:
            let itemC = ItemC(title: "New Cell", description: "New Cell New You It's The Only Way")
            dataSourceC.appendItem(value: itemC.convertToViewModel(), in: 0)
        default:
            break
        }
    }
    
    @IBAction func removeButtonTapped(_ sender: UIButton) {
        guard let selectedItems = collectionView.indexPathsForSelectedItems else { return }
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            dataSourceA.removeItems(at: selectedItems)
        case 1:
            dataSourceB.removeItems(at: selectedItems)
        case 2:
            dataSourceC.removeItems(at: selectedItems)
        default:
            break
        }
    }
}


