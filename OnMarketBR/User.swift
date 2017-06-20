//
//  User.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 20/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import SwiftyJSON

class User: NSObject, NSCoding {
    
    var id: Int!
    var token: String!
    var name: String!
    var cpf: String!
    var email: String!
    var password: String!
    
    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.token = json["token"].stringValue
        self.email = json["email"].stringValue
        self.cpf = json["cpf"].stringValue
        self.password = json["password"].stringValue
    }

    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        email = aDecoder.decodeObject(forKey: "email") as! String
        token = aDecoder.decodeObject(forKey: "token") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(token, forKey: "token")
    }
    // Mark :- Authentication
    static var _currentUser: User!
    
    static var currentUser: User? {
        get {
            if (_currentUser != nil) {
                return _currentUser
            } else {
                let defaults = UserDefaults.standard
                if let unarchivedObject = defaults.object(forKey: "currentUser") as? NSData {
                    _currentUser = NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? User
                    return _currentUser
                }
                return nil
            }
        }
        
        set {
            _currentUser = newValue
            let defaults = UserDefaults.standard
            
            if let user = newValue {
                let archivedObject = NSKeyedArchiver.archivedData(withRootObject: user)
                defaults.set(archivedObject, forKey: "currentUser")
            } else {
                defaults.removeObject(forKey: "currentUser")
            }
        }
    }
    
    static var isLoggedIn: Bool {
        return currentUser != nil
    }

}
