//
//  Product.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 14/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import SwiftyJSON

class Product {
    
    var id: Int?
    var name: String?
    var description: String?
    var price: Double?
    var display_price: String?
    var available_on: String?
    var slug: String?
    var shipping_category_id: Int?
    var total_on_hand: Int?
    var thumbnailURL: String?
    var imageURL: String?
    var allVariants = [Variant]()
    var imageURLs = [String]()
    var properties = [ProductProperty]()
    
    var masterVariant: Variant {
        return allVariants.filter({ $0.isMaster } )[0]
    }
    
    var variants: [Variant]  {
        return allVariants.filter({ !$0.isMaster } )
    }
    
    var hasVariants: Bool {
        return variants.count > 0
    }
    
    var propertiesCount: Int {
        return properties.count
    }
    
    init(fromJSON json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.description = json["description"].stringValue
        self.price = json["price"].doubleValue
        self.display_price = json["display_price"].stringValue
        self.available_on = json["available_on"].stringValue
        self.slug = json["slug"].stringValue
        self.shipping_category_id = json["shipping_category_id"].intValue
        self.total_on_hand = json["total_on_hand"].intValue

        if let imageURL = json["master"]["images"][0]["product_url"].rawString() {
            self.thumbnailURL = "http://dev.onmarketbr.com.br/\(imageURL)"
        }
        
        for variantJSON in json["variants_including_master"].arrayValue {
            let variant = Variant(fromJSON: variantJSON)
            self.allVariants.append(variant)
        }
        
        for propertyJSON in json["product_properties"].arrayValue {
            let property = ProductProperty(fromJSON: propertyJSON)
            self.properties.append(property)
        }
        
        for imageJSON in json["images"].arrayValue {
            self.imageURLs.append(imageJSON["large_url"].stringValue)
        }
    }
    
}
