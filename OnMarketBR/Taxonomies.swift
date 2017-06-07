//
//  Taxonomies.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 06/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import SwiftyJSON

class Taxonomies: NSObject {

    var id: Int!
    var name: String!
    var count: Int!
    var pages: Int!
    var current_page: Int!
    var root = [Root]()
    var taxons = [Taxons]()

    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.count = json["count"].intValue
        self.pages = json["pages"].intValue
        self.current_page = json["current_pge"].intValue
    }
}
