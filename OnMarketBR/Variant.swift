//
//  Variant.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 14/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import SwiftyJSON

class Variant {
    var id: Int?
    var sku: String?
    var name: String?
    var price: String?
    var isMaster = false
    var optionsText = ""
    
    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.sku = json["sku"].stringValue
        self.name = json["name"].stringValue
        self.price = json["display_price"].stringValue
        self.isMaster = json["is_master"].boolValue
        self.optionsText = json["options_text"].stringValue
    }
}
