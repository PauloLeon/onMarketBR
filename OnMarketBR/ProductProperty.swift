//
//  ProductProperty.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 14/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import SwiftyJSON

class ProductProperty: NSObject {
    var id: Int?
    var name: String?
    var value: String?
    
    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.name = json["presentation"].stringValue
        self.value = json["value"].stringValue
    }
}
