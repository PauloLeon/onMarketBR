//
//  SubCategoriaCollectionViewController.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 30/05/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit
import SideMenu


private let reuseIdentifier = "Cell"
private var quantidadeMockup = 0

class SubCategoriaCollectionViewController: UICollectionViewController {
    fileprivate let itemsPerRow: CGFloat = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white

    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProdutosCollectionViewCell
        cell.backgroundColor = UIColor.white
        let imageName = "toddy"
        if let image = UIImage(named: imageName){
            cell.produtoImage.image =  image
        }
        cell.produtoName.text = "Achocolatado Toddy"
        cell.produtoDesc.text = "Original Pote 200g"
        cell.precoProduto.text = "R$ 4,61"
        cell.lblEconomia.text = "R$ 0,06"
        //if for mockup
        if(indexPath.row == 0){
            cell.produtoQuantidade.text = "\(quantidadeMockup)"
            cell.plusButton.addTarget(self, action: #selector(addingProduct(button:)), for:.touchUpInside)
            cell.minusButton.addTarget(self, action: #selector(removeProduct(button:)), for:.touchUpInside)
        }else{
            cell.produtoQuantidade.text = "0"
        }
        roundCells(cell: cell)

        return cell
    }
    
    func addingProduct(button: UIButton){
        quantidadeMockup = quantidadeMockup + 1
        self.collectionView?.reloadData()
    }
    
    func removeProduct(button: UIButton){
        if( quantidadeMockup > 0){
            quantidadeMockup = quantidadeMockup - 1
            self.collectionView?.reloadData()
        }
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
        SideMenuManager.menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
