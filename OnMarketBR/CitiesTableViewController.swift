//
//  CitiesTableViewController.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 05/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CitiesTableViewController: UITableViewController{
    
    let resultsViewController = UITableViewController()
    let searchController = UISearchController(searchResultsController: nil)
    var locais = [Cities]()
    var filteredCandies = [Cities]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        locais = [
            Cities(name:"Belém, Batista Campos"),
            Cities(name:"Belém, Cremação"),
            Cities(name:"Belém, Marco"),
            Cities(name:"Belém, Reduto")]
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func filterContentForSearchText(searchText: String) {
        filteredCandies = locais.filter { cidade in
        return  cidade.name.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredCandies.count
        }
        return locais.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cidade: Cities
        if searchController.isActive && searchController.searchBar.text != "" {
            cidade = filteredCandies[indexPath.row]
        } else {
            cidade = locais[indexPath.row]
        }
        cell.textLabel?.text = cidade.name
        return cell
    }

}

extension CitiesTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        //filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension CitiesTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        _ = searchController.searchBar
        //let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
