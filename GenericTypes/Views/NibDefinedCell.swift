//
//  NibDefinedView.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/25/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

class NibDefinedCell: UICollectionViewCell {
    var nibName: String {
        return String(describing: type(of: self)).components(separatedBy: ".").first!
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
 
    func xibSetup() {
        guard let cell = loadViewFromNib() else { return }
        cell.frame = bounds
        cell.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        connectXib(xibView: cell.contentView)
    }
    
    func loadViewFromNib() -> UICollectionViewCell? {
        let nib = UINib(nibName: nibName, bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).first as? UICollectionViewCell
        
        return cell //nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func connectXib(xibView: UIView) {
        contentView.addSubview(xibView)
    }
}
