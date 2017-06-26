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
    var addressWork:AddressCache?
    var addressHome:AddressCache?
    var flagHome = false
    var flagWork = false
    
    //faltando o bairro
    func save(fullname: String, address1: String, address2: String, city: String, zipcode: String, number: String, style: Int16) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "AddressCache", in: managedContext)
        if let addressEntity = entity {
            let address = AddressCache(entity: addressEntity, insertInto: managedContext)
            address.fullname = fullname
            address.address1 = address1
            address.address2 =  address2
            address.city = city
            address.zipcode = zipcode
            address.number = number
            address.style = style
            do {
                try managedContext.save()
                addressCache.append(address)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }  
    }
    
    func fetch(tableView: UITableView){
        guard let appDelegate =  UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.managedObjectContext
        do {
            addressCache = try managedContext.fetch(AddressCache.fetchRequest())
            splitAddress()
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func delete(fullname: String, tableview: UITableView){
        guard let appDelegate =  UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.managedObjectContext
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
    }
    
    func splitAddress(){
        if self.addressCache.count > 0{
            for (index, address) in self.addressCache.enumerated() {
                if address.style == 0{
                    self.addressHome = address
                    self.addressHomeExist()
                    self.addressCache.remove(at: index)
                }
            }
            for (index, address) in self.addressCache.enumerated() {
                if address.style == 1{
                    self.addressWork = address
                    self.addressWorkExist()
                    self.addressCache.remove(at: index)
                }
            }
        }
    }

    func addressHomeExist(){
        self.flagHome = true
    }
    func addressWorkExist(){
        self.flagWork = true
    }
}
