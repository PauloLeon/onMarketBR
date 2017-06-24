//
//  State.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 24/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import SwiftyJSON

class State: NSObject {
    
    var id: Int?
    var country_id: Int?
    var name: String?
    var abbr: String?
    
    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.country_id = json["country_id"].intValue
        self.name = json["name"].stringValue
        self.abbr = json["abbr"].stringValue
    }
}
