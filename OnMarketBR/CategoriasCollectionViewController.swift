//
//  CategoriasCollectionViewController.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 26/05/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit
import SideMenu
import SVProgressHUD

private let reuseIdentifier = "Cell"
class CategoriasCollectionViewController: UICollectionViewController {
    
    var isLoading = true
    var taxonomies = [Taxonomies]()
    fileprivate let itemsPerRow: CGFloat = 3
    let itens:Array = ["ic_alimentos","ic_bebidas","ic_beleza","ic_descartaveis","ic_higiene","ic_infantil","ic_lavanderia","ic_limpeza","ic_mercearia_doce","ic_oferta","ic_petshop","ic_utilitarios"]
    let itensLbl:Array = ["Alimentos","Bebidas","Beleza","Descartáveis","Higiene","Infantil","Lavanderia","Limpeza","Mercearia","Oferta","Petshop","Utilitarios"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting 
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        setupSideMenu()
        SVProgressHUD.show()
        fetchCategorias()
    }
    
    //for back button in navigation, don't mess with the UX
    override func viewWillDisappear(_ animated: Bool) {
        if SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (isLoading){
            return 0
        }else{
            return self.taxonomies.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoriaCollectionViewCell
        if(isLoading){
            
        }else{
            cell.backgroundColor = UIColor.init(colorLiteralRed: 0.07, green: 0.47, blue: 0.81, alpha: 1.00)
            let imageName = itens[indexPath.row]
            if let image = UIImage(named: imageName){
                cell.imageCentral.image =  image
            }
            cell.lblCategorias.text = self.taxonomies[indexPath.row].name
            RoundedHelper.roundCells(cell: cell)
        }
        return cell
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func setupSideMenu() {
        // Define the menus
        SideMenuManager.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        SideMenuManager.menuWidth = max(round(min((self.view.frame.width), (self.view.frame.height)) * 0.85), 240)
    }
    
    //ApiClient
    func fetchCategorias() {
        TaxonomiesApiClient.getTaxonomies({ taxonomies in
            self.taxonomies = taxonomies
            self.isLoading = false
            SVProgressHUD.dismiss()
            self.collectionView?.reloadData()
        }, failure: { apiError in
            self.showApiErrorAlert(apiError)
        })
    }
    
    func showApiErrorAlert(_ apiError: ApiError) {
        showAlert("Whooops!!!", message: apiError.errorMessage(), handler: nil)
    }
    
    func showAlert(_ title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: handler)
        ac.addAction(ok)
        present(ac, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "segueToSubCategoria" {
            let subCategoriaCV = segue.destination as! SubCategoriaTableViewController
            let cell = sender as! CategoriaCollectionViewCell
            let indexPaths = self.collectionView?.indexPath(for: cell)
            subCategoriaCV.subCategorias = self.taxonomies[(indexPaths?.row)!].root
        }
    }
    
    
}
