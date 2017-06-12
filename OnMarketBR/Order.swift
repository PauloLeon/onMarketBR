//
//  Order.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 11/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import SwiftyJSON

class Order: NSObject, NSCoding {
    enum State {
        case cart
        case address
        case payment
        case complete
    }
    var id: String!
    var number: String!
    var user_id: Int!
    var state: State = .cart
    var created_at: String!
    var updated_at: String!
    var completed_at: String!
    var shipment_state: String!
    var payment_state: String!
    var email: String!
    var special_instructions:String!
    var channel:String!
    var included_tax_total:Float!
    var additional_tax_total:Float!
    var display_included_tax_total:String!
    var display_additional_tax_total:String!
    var currency:String!
    var considered_risky:String!
    var canceler_id:String!
    var display_item_total:String!
    var total_quantity:String!
    var display_total:String!
    var display_ship_total:String!
    var display_tax_total:String!
    var display_adjustment_total:String!
    var token:String!
    var item_total: Float!
    var ship_total: Float!
    var tax_total: Float!
    var total: Float!
    var lineItems = [LineItem]()
    
    var itemsCount: Int {
        return lineItems.count
    }
    
    init(fromJSON json: JSON) {
        self.id = json["id"].stringValue
        self.number = json["number"].stringValue
        self.user_id = json["user_id"].intValue
        self.created_at = json["created_at"].stringValue
        self.updated_at = json["updated_at"].stringValue
        self.email = json["email"].stringValue
        self.special_instructions = json["special_instructions"].stringValue
        self.channel = json["channel"].stringValue
        self.included_tax_total = json["included_tax_total"].floatValue
        self.additional_tax_total = json["additional_tax_total"].floatValue
        self.display_included_tax_total = json["display_included_tax_total"].stringValue
        self.display_additional_tax_total = json["display_additional_tax_total"].stringValue
        self.currency = json["currency"].stringValue
        self.considered_risky = json["considered_risky"].stringValue
        self.canceler_id = json["canceler_id"].stringValue
        self.display_item_total = json["display_item_total"].stringValue
        self.total_quantity = json["total_quantity"].stringValue
        self.display_total = json["display_total"].stringValue
        self.display_ship_total = json["display_ship_total"].stringValue
        self.display_tax_total = json["display_tax_total"].stringValue
        self.display_adjustment_total = json["display_adjustment_total"].stringValue
        self.token = json["token"].stringValue
        self.completed_at = json["completed_at"].stringValue
        self.item_total = json["item_total"].floatValue
        self.ship_total = json["ship_total"].floatValue
        self.tax_total = json["tax_total"].floatValue
        self.total = json["total"].floatValue
        for lineItemJSON in json["line_items"].arrayValue {
            let lineItem = LineItem(fromJSON: lineItemJSON)
            self.lineItems.append(lineItem)
        }
        switch json["state"].stringValue {
            case "address": self.state = .address
            case "payment": self.state = .payment
            case "complete": self.state = .complete
            default: self.state = .cart
        }
    }
    
    // Mark :- NSCoding
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? String
        completed_at = aDecoder.decodeObject(forKey: "completed_at") as? String
        total = aDecoder.decodeObject(forKey: "total") as? Float
        lineItems = aDecoder.decodeObject(forKey: "lineItems") as! [LineItem]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(completed_at, forKey: "completed_at")
        aCoder.encode(total, forKey: "total")
        aCoder.encode(lineItems, forKey: "lineItems")
    }
    
    // MARK:- Current Order / Cart
    static var _currentOrder: Order!
    
    static var currentOrder: Order? {
        get {
            if (_currentOrder != nil) {
                return _currentOrder
            } else {
                let defaults = UserDefaults.standard
                if let unarchivedObject = defaults.object(forKey: "currentOrder") as? NSData {
                    _currentOrder = NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? Order
                    return _currentOrder
                }
                return nil
            }
        }
        
        set {
            _currentOrder = newValue
            let defaults = UserDefaults.standard
            
            if let order = newValue {
                let archivedObject = NSKeyedArchiver.archivedData(withRootObject: order)
                defaults.set(archivedObject, forKey: "currentOrder")
            } else {
                defaults.removeObject(forKey: "currentOrder")
            }
        }
    }
    
    static var hasCurrentOrder: Bool {
        return currentOrder != nil && currentOrder!.id != ""
    }
    
    var isEmpty: Bool {
        return lineItems.count == 0
    }
    
    func formattableDate() -> NSDate {
        let formatter = DateFormatter()
        
        // 2016-08-11T12:29:13.800Z
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ"
        
        return formatter.date(from: completed_at)! as NSDate
    }


}
