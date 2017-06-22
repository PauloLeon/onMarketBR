//
//  Address.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 22/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import SwiftyJSON

class Address: NSObject {
    
    var id: Int?
    var address1: String?
    var address2: String?
    var city: String?
    var state_name: String?
    var state_id: Int?
    var country_id: String?
    var neighborhood: String?
    var number: Int?
    var complement: String?
    var user_id: Int?
    
    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.address1 = json["address1"].stringValue
        self.address2 = json["address2"].stringValue
        self.city = json["city"].stringValue
        self.state_name = json["state_name"].stringValue
        self.state_id = json["state_id"].intValue
        self.country_id = json["country_id"].stringValue
        self.neighborhood = json["neighborhood"].stringValue
        self.number = json["number"].intValue
        self.complement = json["complemet"].stringValue
        self.user_id = json["user_id"].intValue
    }
}
