//
//  AlertControllerHelper.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 09/07/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit

class AlertControllerHelper: NSObject {
    
    static func showApiErrorAlert(_ title: String, message: String, view: UIViewController, handler: ((UIAlertAction) -> Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: handler)
        ac.addAction(ok)
        view.present(ac, animated: true, completion: nil)
    }
    
    static func showApiSuccessAlert(_ title: String, message: String, view: UIViewController, handler: ((UIAlertAction) -> Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: handler)
        ac.addAction(ok)
        view.present(ac, animated: true, completion: nil)
    }
}
