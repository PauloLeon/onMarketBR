//
//  Root.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 06/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import SwiftyJSON

class Root: NSObject {
    
    var id: Int!
    var name: String!
    var permalink: String!
    var pretty_name: String!
    var parent_id: Int!
    var taxonomy_id: Int!
    var taxons = [Taxons]()

    
    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.permalink = json["permalink"].stringValue
        self.pretty_name = json["pretty_name"].stringValue
        self.parent_id = json["parent_id"].intValue
        self.taxonomy_id = json["taxonomy_id"].intValue
        for taxonsJSON in json["taxons"].arrayValue {
            let taxon = Taxons(fromJSON: taxonsJSON)
            self.taxons.append(taxon)
        }
    }

}
