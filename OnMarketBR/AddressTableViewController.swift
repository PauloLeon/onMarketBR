//
//  AddressTableViewController.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 21/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit
import CoreData

let reusePink = "cellPink"
let reuseWhite = "cellWhite"

class AddressTableViewController: UITableViewController {

    var countPinkCell = 1
    var addressCacheHelper = AddressCacheHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addressCacheHelper.fetch(tableView: tableView)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return countPinkCell
        case 1:
            return addressCacheHelper.addressCache.count
        default:
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return "Outros Locais de Entrega"
        }
        return ""
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 125.0;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 && indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: reusePink, for: indexPath) as! PinkTableViewCell
            RoundedHelper.roundView(view: cell.roundedView)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseWhite, for: indexPath) as! AddressTableViewCell
        if indexPath.row == 1 && indexPath.section == 1 {
            let imageName = "ic_work"
            if let image = UIImage(named: imageName){
                cell.imageHome.image =  image
            }
        }
        if addressCacheHelper.addressCache.count > 0{
            let addresscache = addressCacheHelper.addressCache[indexPath.row]
            cell.name.text = addresscache.fullname
        }
        RoundedHelper.roundView(view: cell.roundedView)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        if editActionsForRowAt.row == 0 && editActionsForRowAt.section == 0{
            let delete = UITableViewRowAction(style: .destructive, title: "Apagar") { action, index in
                self.countPinkCell = 0
                tableView.reloadData()
            }
            delete.backgroundColor = .red
            return [delete]
        }
        let edit = UITableViewRowAction(style: .normal, title: "Editar") { action, index in
        }
        edit.backgroundColor = .lightGray
        
        let delete = UITableViewRowAction(style: .destructive, title: "Apagar") { action, index in
            let cell = tableView.cellForRow(at: editActionsForRowAt) as! AddressTableViewCell
            if let fullname = cell.name.text{
                self.addressCacheHelper.delete(fullname: fullname, tableview: tableView)
            }
        }
        delete.backgroundColor = .red
        
        return [delete, edit]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: false)
    }
}
