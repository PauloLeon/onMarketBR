//
//  SubCategoriaCollectionViewController.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 30/05/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit
import SideMenu
import SDWebImage
import SVProgressHUD

private let reuseIdentifier = "Cell"
private var quantidadeMockup = 0

class ProdutosCollectionViewController: UICollectionViewController {
    
    fileprivate let itemsPerRow: CGFloat = 2
    var subCategoria: Taxons?
    var products = [Product]()
    var currentOrder: Order?
    var isLoading = true

    override func viewDidLoad() {
        super.viewDidLoad()
        if let sub = subCategoria {
            print(sub.name)
            print(sub.id)
        }
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        SVProgressHUD.show()
        fetchCurrentOrder()
        fetchProdutos()
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
        if(isLoading){
            return 0
        }else{
            return self.products.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProdutosCollectionViewCell
        if(isLoading){
        }else{
            cell.backgroundColor = UIColor.white
            let imageName = "toddy"
            if let image = UIImage(named: imageName){
                cell.produtoImage.sd_setImage(with: URL(string:self.products[indexPath.row].thumbnailURL!), placeholderImage: image)
            }
            cell.produtoName.text = self.products[indexPath.row].name
            cell.produtoDesc.text = "Original Pote 200g"
            cell.precoProduto.text = self.products[indexPath.row].display_price
            cell.lblEconomia.text = "not today"
            cell.addCart.addTarget(self, action: #selector(addingProduct(button:)), for:.touchUpInside)
            cell.addCart.tag = indexPath.row
            roundCells(cell: cell)
            return cell
        }
        roundCells(cell: cell)
        return cell
    }
    
    func addingProduct(button: UIButton){
        SVProgressHUD.show()
        if !Order.hasCurrentOrder {
            OrderApiClient.createOrder({ order in
                Order.currentOrder = order
                self.createProductInCart(button: button)
            }, failure: { apiError in
                self.showApiErrorAlert(apiError)
            })
        } else {
            let idForVariant = fetchProductInCart(button: button)
            if(idForVariant != -1){
                addProductToCart(button: button, idForVariant: idForVariant)
            }else{
                createProductInCart(button: button)
            }
        }
    }
    
    func addProductToCart(button: UIButton, idForVariant: Int){
        if let current = Order.currentOrder {
            if let idForRequest = current.number {
                var quantidade: Int?
                for item in current.lineItems{
                    if(item.variant_id == self.products[button.tag].id){
                        quantidade = item.quantity!
                    }
                }
                var data = URLRequestParams()
                data["line_item[quantity]"] = quantidade!+1
                CartApiClient.updateLineItem(idForRequest, lineItemID: idForVariant, data: data, success: {
                    order in
                    SVProgressHUD.dismiss()
                    self.showSuccessAlert()
                }, failure: { apiError in
                    self.showApiErrorAlert(apiError)
                    SVProgressHUD.dismiss()
                })
            }
        }
    }
    
    func createProductInCart(button: UIButton){
        if let current = Order.currentOrder {
            if let id = current.number {
               var data = URLRequestParams()
                data["line_item[variant_id]"] = self.products[button.tag].id
                data["line_item[quantity]"] = 1
                CartApiClient.addLineItem(id, data: data, success: {
                    order in
                    SVProgressHUD.dismiss()
                    self.showSuccessAlert()
                }, failure: { apiError in
                    self.showApiErrorAlert(apiError)
                    SVProgressHUD.dismiss()
                })
            }
        }
    }
    
    func fetchProductInCart(button: UIButton) -> Int{
        if let current = Order.currentOrder {
            if (!current.lineItems.isEmpty){
                for item in current.lineItems {
                    if(item.variant_id == self.products[button.tag].id){
                        return item.id!
                    }
                }
            }
        }
        return -1
    }

    func fetchCurrentOrder(){
        OrderApiClient.current({ currentOrder in
            Order.currentOrder = currentOrder
            print("getOrderOK")
        }, failure: { apiError in
            self.showApiErrorAlert(apiError)
        })
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
    
    func fetchProdutos(){
        var data = URLRequestParams()
        if let subcategoria = subCategoria {
            data["q[shipping_category_id]"] = subcategoria.id
        }
        ProductApiClient.products(data, success:{ products in
            self.products = products
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
    
    func showSuccessAlert() {
        showAlert("Concluído", message: "Produto adicionado no carrinho", handler: nil)
    }
    
    func showAlert(_ title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: handler)
        ac.addAction(ok)
        present(ac, animated: true, completion: nil)
    }
}
