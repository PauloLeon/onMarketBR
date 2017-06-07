//
//  Taxons.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 06/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import SwiftyJSON

class Taxons: NSObject {
    
    var id: Int!
    var name: String!
    var permalink: String!
    var pretty_name: String!
    var parent_id: Int!
    var taxonomy_id: Int!
    
    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.permalink = json["permalink"].stringValue
        self.pretty_name = json["position"].stringValue
        self.parent_id = json["parent_id"].intValue
        self.taxonomy_id = json["taxonomy_id"].intValue
    }

}
