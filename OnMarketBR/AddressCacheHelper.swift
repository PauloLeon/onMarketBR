//
//  AddressCacheHelper.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 24/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit
import CoreData

class AddressCacheHelper: NSObject {

    var addressCache: [AddressCache] = []
    
    func save(fullname: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        if #available(iOS 10.0, *) {
            let managedContext = appDelegate.persistentContainer.viewContext
            let address = AddressCache(entity: AddressCache.entity(), insertInto: managedContext)
            address.fullname = fullname
            do {
                try managedContext.save()
                addressCache.append(address)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        } else {}
    }
    
    func fetch(tableView: UITableView){
        guard let appDelegate =  UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        if #available(iOS 10.0, *) {
            let managedContext = appDelegate.persistentContainer.viewContext
            do {
                addressCache = try managedContext.fetch(AddressCache.fetchRequest())
                tableView.reloadData()
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func delete(fullname: String, tableview: UITableView){
        guard let appDelegate =  UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        if #available(iOS 10.0, *) {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<AddressCache> = AddressCache.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "fullname = %@", fullname)
            do {
                let result = try managedContext.fetch(fetchRequest).first
                if let deleteObj = result {
                    managedContext.delete(deleteObj)
                    fetch(tableView: tableview)
                } else{
                    print("Objeto não existe no banco")
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
