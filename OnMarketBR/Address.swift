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
    var fullname: String?
    var address1: String?
    var address2: String?
    var city: String?
    var state_text: String?
    var state_id: Int?
    var phone: String?
    var country_id: Int?
    var number: Int?
    var user_id: Int?
    var zipcode: String?
    var state: State?
    
    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.address1 = json["address1"].stringValue
        self.address2 = json["address2"].stringValue
        self.city = json["city"].stringValue
        self.state_text = json["state_text"].stringValue
        self.state_id = json["state_id"].intValue
        self.country_id = json["country_id"].intValue
        self.number = json["number"].intValue
        self.user_id = json["user_id"].intValue
        self.phone = json["phone"].stringValue
        self.zipcode = json["zipcode"].stringValue
        self.state = State(fromJSON: json["state"])
    }
}
