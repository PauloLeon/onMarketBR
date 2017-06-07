//
//  CategoriasCollectionViewController.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 26/05/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit
import SideMenu

private let reuseIdentifier = "Cell"

class CategoriasCollectionViewController: UICollectionViewController {
    
    fileprivate let itemsPerRow: CGFloat = 3
    
    let itens:Array = ["ic_alimentos","ic_bebidas","ic_beleza","ic_descartaveis","ic_higiene","ic_infantil","ic_lavanderia","ic_limpeza","ic_mercearia_doce","ic_oferta","ic_petshop","ic_utilitarios"]
    
    let itensLbl:Array = ["Alimentos","Bebidas","Beleza","Descartáveis","Higiene","Infantil","Lavanderia","Limpeza","Mercearia","Oferta","Petshop","Utilitarios"]

    override func viewDidLoad() {
        super.viewDidLoad()
        //setting 
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        setupSideMenu()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoriaCollectionViewCell
        
        cell.backgroundColor = UIColor.init(colorLiteralRed: 0.07, green: 0.47, blue: 0.81, alpha: 1.00)
        let imageName = itens[indexPath.row]
        let lblCategorias = itensLbl[indexPath.row]
        if let image = UIImage(named: imageName){
            cell.imageCentral.image =  image
        }
        cell.lblCategorias.text = lblCategorias
        
        roundCells(cell: cell)

        return cell
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func roundCells(cell: UICollectionViewCell) {
        cell.layer.cornerRadius = 2.0
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }

    fileprivate func setupSideMenu() {
        // Define the menus
        SideMenuManager.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        SideMenuManager.menuWidth = max(round(min((self.view.frame.width), (self.view.frame.height)) * 0.85), 240)
    }
    
}
