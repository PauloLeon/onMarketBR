//
//  Guest.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 20/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit

class Guest: NSObject,NSCoding {
    
    var tokenGuest: String?
    
    init(token: String) {
        self.tokenGuest = token
    }
    
    required init?(coder aDecoder: NSCoder) {
        tokenGuest = aDecoder.decodeObject(forKey: "tokenGuest") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(tokenGuest, forKey: "tokenGuest")
    }
    
    static var _currentGuest: Guest!
    
    static var currentGuest: Guest? {
        get {
            if (_currentGuest != nil) {
                return _currentGuest
            } else {
                let defaults = UserDefaults.standard
                if let unarchivedObject = defaults.object(forKey: "currentGuest") as? NSData {
                    _currentGuest = NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? Guest
                    return _currentGuest
                }
                return nil
            }
        }
        
        set {
            _currentGuest = newValue
            let defaults = UserDefaults.standard
            
            if let user = newValue {
                let archivedObject = NSKeyedArchiver.archivedData(withRootObject: user)
                defaults.set(archivedObject, forKey: "currentGuest")
            } else {
                defaults.removeObject(forKey: "currentGuest")
            }
        }
    }
    
    static var exists: Bool {
        return currentGuest != nil
    }

}
