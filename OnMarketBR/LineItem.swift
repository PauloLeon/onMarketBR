//
//  LineItems.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 12/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import SwiftyJSON

class LineItem: NSObject, NSCoding {
    
    var id: Int?
    var name: String?
    var desc: String?
    var single_display_amount: String?
    var quantity: Int?
    var price: String?
    var total: String?
    var display_total: String?
    var imageURL: String?
    var in_stock: Bool?
    var variant_id: Int?

    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.single_display_amount = json["single_display_amount"].stringValue
        self.in_stock = json["in_stock"].boolValue
        self.name = json["variant"]["name"].stringValue
        self.variant_id = json["variant_id"].intValue
        self.desc = json["variant"]["description"].stringValue
        self.quantity = json["quantity"].intValue
        self.price = json["price"].stringValue
        self.total = json["total"].stringValue
        self.display_total = json["display_total"].stringValue
        if let image = json["variant"]["images"].arrayValue.first {
            self.imageURL = image["small_url"].stringValue
        }
    }
    
    func updateItem(fromLineItem lineUpdate: LineItem){
        self.id = lineUpdate.id
        self.single_display_amount = lineUpdate.single_display_amount
        self.in_stock = lineUpdate.in_stock
        self.name = lineUpdate.name
        self.variant_id = lineUpdate.variant_id
        self.desc = lineUpdate.desc
        self.quantity = lineUpdate.quantity
        self.price = lineUpdate.price
        self.total = lineUpdate.total
        self.display_total = lineUpdate.display_total
        self.imageURL = lineUpdate.imageURL
    }

    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        quantity = aDecoder.decodeObject(forKey: "quantity") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        price = aDecoder.decodeObject(forKey: "price") as? String
        imageURL = aDecoder.decodeObject(forKey: "imageURL") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(quantity, forKey: "quantity")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(price, forKey: "price")
        aCoder.encode(imageURL, forKey: "imageURL")
    }
}
