//
//  CitiesTableViewController.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 05/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CitiesTableViewController: UITableViewController {
    
    let resultsViewController = UITableViewController()
    var searchController: UISearchController!
    var locais = ["Belém, Batista Campos","Belém, Cremação","Belém, Marco","Belém, Doca"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: self.resultsViewController)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        tableView.tableHeaderView = searchController.searchBar
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return locais.count
        }
        return locais.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = locais[indexPath.row]
        return cell
    }
    
}
