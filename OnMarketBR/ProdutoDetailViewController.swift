//
//  ProdutoDetailViewController.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 02/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit
import SideMenu


class ProdutoDetailViewController: UIViewController {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        settingUI()
    }
    
    func settingUI(){
        if let produto = product{
            let imageName = "toddy"
            if let image = UIImage(named: imageName){
                productImage.sd_setImage(with: URL(string:produto.thumbnailURL!), placeholderImage: image)
            }
            productName.text = produto.name
            productPrice.text = "Unidade - \(produto.display_price ?? "num veio nada")"
        }
    }
    
    fileprivate func setupSideMenu() {
        SideMenuManager.menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }

}
