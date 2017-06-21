//
//  RoundedHelper.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 20/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit

class RoundedHelper: NSObject {
    
   static func roundCells(cell: UICollectionViewCell) {
        cell.layer.cornerRadius = 2.0
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
    
    static func roundView(view: UIView) {
        view.layer.cornerRadius = 2.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.masksToBounds = true
        
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        view.layer.shadowRadius = 2.0
        view.layer.shadowOpacity = 1.0
        view.layer.masksToBounds = false
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath
    }
    
    static func roundButtons(button: UIButton) {
        button.layer.cornerRadius = 20.0
        button.layer.borderWidth = 20.0
        button.layer.borderColor = UIColor.clear.cgColor
        button.layer.masksToBounds = true
    }
    
}
