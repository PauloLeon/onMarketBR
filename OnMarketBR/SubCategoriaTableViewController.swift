//
//  SubCategoriaTableViewController.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 14/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SubCategoriaTableViewController: UITableViewController {

    var subCategorias: Root?

    override func viewDidLoad() {
        super.viewDidLoad()
        //only print in console
        if let sub = subCategorias {
            for taxons in (sub.taxons){
                print(taxons.name)
            }
        }
        //make the navigation itens white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    //for status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numerosDeSub = subCategorias?.taxons.count {
            return numerosDeSub
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        if let sub = subCategorias {
            cell.textLabel?.text = sub.taxons[indexPath.row].name
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "segueToProdutos" {
            let subCategoriaCV = segue.destination as! ProdutosCollectionViewController
            let cell = sender as! UITableViewCell
            let indexPaths = self.tableView?.indexPath(for: cell)
            subCategoriaCV.subCategoria = self.subCategorias?.taxons[(indexPaths?.row)!]
        }
    }
}
