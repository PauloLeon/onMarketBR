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
    
    var product: Product?
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
        if let produto = product{
            let imageName = "toddy"
            if let image = UIImage(named: imageName){
                productImage.sd_setImage(with: URL(string:produto.thumbnailURL!), placeholderImage: image)
            }
            productName.text = produto.name
            productPrice.text = "Unidade - \(produto.display_price ?? "num veio nada")"
            productQuantity.text = "1"
            productTotal.text = produto.display_price
        }
    }
    
    @IBAction func addBtnPressed(sender: UIButton) {
        if let quantidade = Double(productQuantity.text!) {
            let quantidadeNew = quantidade + 1
            productQuantity.text = "\(Int(quantidadeNew))"
            if let produto = product{
                productTotal.text = "R$\(quantidadeNew * produto.price!)"
            }
        }
    }
    @IBAction func minusBtnPressed(sender: UIButton) {
        if let quantidade = Double(productQuantity.text!) {
            if (quantidade>1) {
                let quantidadeNew = quantidade - 1
                productQuantity.text = "\(Int(quantidadeNew))"
                if let produto = product{
                    productTotal.text = "R$\(quantidadeNew * produto.price!)"
                }
            }
        }
    }

    @IBAction func addToCart(_ sender: Any) {
        if let produto = product{
            if let quantidade = productQuantity.text{
                cartHelper.addingProduct(product: produto, quantidade: Int(quantidade)!, viewforAlert: self)
            }
        }
     }
}
