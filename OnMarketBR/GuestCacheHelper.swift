//
//  GuestCacheHelper.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 02/07/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit
import CoreData

class GuestCacheHelper: NSObject {

    var guest:GuestCache?
    

    //faltando o bairro
    func save(token: String, currentOrder:String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "GuestCache", in: managedContext)
        if let guestEntity = entity {
            let guest = GuestCache(entity: guestEntity, insertInto: managedContext)
            guest.token = token
            guest.currentOrder = currentOrder
            do {
                try managedContext.save()
                self.guest = guest
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func fetch(){
        guard let appDelegate =  UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.managedObjectContext
        do {
            var fetchGuest: [GuestCache]
            fetchGuest = try managedContext.fetch(GuestCache.fetchRequestGuest())
            //pegando sempre o primeiro pq somente vem um mesmo
            self.guest = fetchGuest.first
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func delete(token: String){
        guard let appDelegate =  UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest: NSFetchRequest<GuestCache> = GuestCache.fetchRequestGuest()
        fetchRequest.predicate = NSPredicate(format: "token = %@", token)
        do {
            let result = try managedContext.fetch(fetchRequest).first
            if let deleteObj = result {
                managedContext.delete(deleteObj)
            } else{
                print("Objeto não existe no banco")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func exists(guestCacheHelper: GuestCacheHelper) -> Bool {
        return guestCacheHelper.guest != nil
    }
    
    
}
