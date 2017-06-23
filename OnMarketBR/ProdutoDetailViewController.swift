//
//  ProdutoDetailViewController.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 02/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit
import SideMenu
import SVProgressHUD

class ProdutoDetailViewController: UIViewController {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var productTotal: UILabel!
    
    var productViewModel: ProductViewModel?
    let cartHelper = CartHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        settingUI()
    }
    
    //for back button in navigation, don't mess with the UX
    override func viewWillDisappear(_ animated: Bool) {
        if SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
        }
    }
    
    func settingUI(){
        if let produto = productViewModel{
            productImage = produto.productImage
            productName.text = produto.productName
            productPrice.text = "Unidade - \(produto.productPrice)"
            productQuantity.text = produto.getQuantidadeForView()
            productTotal.text = produto.productPrice
        }
    }
    
    @IBAction func addBtnPressed(sender: UIButton) {
        if let produto = productViewModel{
            produto.quantidadeView = produto.quantidadeView+1
            productQuantity.text = produto.getQuantidadeForView()
            productTotal.text = produto.getQuantidadeForView()
        }
    }
    @IBAction func minusBtnPressed(sender: UIButton) {
        if let produto = productViewModel{
            if produto.quantidadeView>1 {
                produto.quantidadeView = produto.quantidadeView-1
                productQuantity.text = produto.getQuantidadeForView()
                productTotal.text = produto.getQuantidadeForView()
            }
        }
    }
    
    @IBAction func addToCart(_ sender: Any) {
        if let produto = productViewModel?.product{
            if let quantidade = productQuantity.text{
                cartHelper.addingProduct(product: produto, quantidade: Int(quantidade)!, viewforAlert: self)
            }
        }
     }
}
