//
//  GuestCache+CoreDataProperties.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 02/07/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import Foundation
import CoreData


extension GuestCache {

    @nonobjc public class func fetchRequestGuest() -> NSFetchRequest<GuestCache> {
        return NSFetchRequest<GuestCache>(entityName: "GuestCache")
    }

    @NSManaged public var token: String?
    @NSManaged public var currentOrder: String?

}
