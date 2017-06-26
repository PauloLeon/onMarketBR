//
//  AddressCache+CoreDataProperties.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 26/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import Foundation
import CoreData


extension AddressCache {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AddressCache> {
        return NSFetchRequest<AddressCache>(entityName: "AddressCache")
    }

    @NSManaged public var address1: String?
    @NSManaged public var address2: String?
    @NSManaged public var city: String?
    @NSManaged public var country_id: Int16
    @NSManaged public var fullname: String?
    @NSManaged public var id: Int16
    @NSManaged public var number: String?
    @NSManaged public var phone: String?
    @NSManaged public var state_id: Int16
    @NSManaged public var state_text: String?
    @NSManaged public var user_id: Int16
    @NSManaged public var zipcode: String?
    @NSManaged public var style: Int16

}
