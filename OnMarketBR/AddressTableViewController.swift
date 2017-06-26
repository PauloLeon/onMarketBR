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
let reuseDefault = "cellDefault"

class AddressTableViewController: UITableViewController {

    var countPinkCell = 1
    var addressCacheHelper = AddressCacheHelper()
    var flagForStyle = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        flagForStyle = 2
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
            return 2
        default:
            return addressCacheHelper.addressCache.count
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

        if indexPath.row == 0 && indexPath.section == 1 {
            if addressCacheHelper.flagHome {
                let cell = tableView.dequeueReusableCell(withIdentifier: reuseWhite, for: indexPath) as! AddressTableViewCell
                let addresscache = addressCacheHelper.addressHome!
                cell.name.text = addresscache.fullname
                cell.address.text = addresscache.address1
                cell.address2.text = addresscache.address2
                if (addresscache.address2?.isEmpty)! {
                    cell.address2.text = "Complemento vazio"
                }
                cell.cepBairro.text = "\(addresscache.zipcode ?? "99999-999"),\(addresscache.number ?? "9999")"
                cell.cityState.text = addresscache.city
                RoundedHelper.roundView(view: cell.roundedView)
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseDefault, for: indexPath) as! DefaultTableViewCell
            RoundedHelper.roundView(view: cell.roundedView)
            return cell

        }else if indexPath.row == 1 && indexPath.section == 1{
            if addressCacheHelper.flagWork {
                let cell = tableView.dequeueReusableCell(withIdentifier: reuseWhite, for: indexPath) as! AddressTableViewCell
                let imageName = "ic_work"
                if let image = UIImage(named: imageName){
                    cell.imageHome.image =  image
                }
                let addresscache = addressCacheHelper.addressWork!
                cell.name.text = addresscache.fullname
                cell.address.text = addresscache.address1
                cell.address2.text = addresscache.address2
                if (addresscache.address2?.isEmpty)! {
                    cell.address2.text = "Complemento vazio"
                }
                cell.cepBairro.text = "\(addresscache.zipcode ?? "99999-999"),\(addresscache.number ?? "9999")"
                cell.cityState.text = addresscache.city
                RoundedHelper.roundView(view: cell.roundedView)
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseDefault, for: indexPath) as! DefaultTableViewCell
            let imageName = "ic_work"
            if let image = UIImage(named: imageName){
                cell.img.image =  image
            }
            RoundedHelper.roundView(view: cell.roundedView)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseWhite, for: indexPath) as! AddressTableViewCell

        if indexPath.section == 2{
            if addressCacheHelper.addressCache.count > 0{
                let addresscache = addressCacheHelper.addressCache[indexPath.row]
                cell.name.text = addresscache.fullname
                cell.address.text = addresscache.address1
                cell.address2.text = addresscache.address2
                if (addresscache.address2?.isEmpty)! {
                    cell.address2.text = "Complemento vazio"
                }
                cell.cepBairro.text = "\(addresscache.zipcode ?? "99999-999"),\(addresscache.number ?? "9999")"
                cell.cityState.text = addresscache.city
            }
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
            if editActionsForRowAt.row == 0 && editActionsForRowAt.section == 1 {
                self.flagForStyle = 0
                self.performSegue(withIdentifier: "segueToOtherLocal", sender: self)
            } else if editActionsForRowAt.row == 1 && editActionsForRowAt.section == 1 {
                self.flagForStyle = 1
                self.performSegue(withIdentifier: "segueToOtherLocal", sender: self)
            }
        }
        edit.backgroundColor = .lightGray
        
        if editActionsForRowAt.section == 2{
            let delete = UITableViewRowAction(style: .destructive, title: "Apagar") { action, index in
                let cell = tableView.cellForRow(at: editActionsForRowAt) as! AddressTableViewCell
                if let fullname = cell.name.text{
                    self.addressCacheHelper.delete(fullname: fullname, tableview: tableView)
                }
            }
            delete.backgroundColor = .red
            
            return [delete, edit]
        }
        return [edit]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToOtherLocal"{
            let addAddressVC = segue.destination as! AddAddressViewController
            //estilo determina se vai ser um local customizado
            if flagForStyle == 2{
                addAddressVC.style = 2
            }else if flagForStyle == 0{
                addAddressVC.style = 0
            }else if flagForStyle == 1{
                addAddressVC.style = 1
            }
        }
    }
}
