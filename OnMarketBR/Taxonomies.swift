//
//  Taxonomies.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 06/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

//  var count: Int!
//  var pages: Int!
//  var current_page: Int!

import SwiftyJSON

public class Taxonomies: NSObject {
    
    var id: Int!
    var name: String!
    var root: Root

    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.root = Root(fromJSON: json["root"])
    }
}
