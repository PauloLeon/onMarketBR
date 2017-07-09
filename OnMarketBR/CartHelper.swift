//
//  CartHelper.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 19/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit
import SVProgressHUD

class CartHelper: NSObject {
    
    override init() {
        super.init()
        self.fetchCurrentOrder()
    }
    
    func fetchCurrentOrder(){
        let guestCache = GuestCacheHelper()
        guestCache.fetch()
        let exist = !guestCache.exists(guestCacheHelper: guestCache)
        if User.isLoggedIn || !Guest.exists ||  exist{
            OrderApiClient.current({ currentOrder in
                Order.currentOrder = currentOrder
                print("getOrderOK")
            }, failure: { apiError in
                print(apiError)
            })
        }else{
            OrderApiClient.guestCart((Guest.currentGuest?.order)!,
                        success: {currentOrder in
                                  Order.currentOrder = currentOrder
                                  print("getOrderOK")},
                        failure: { apiError in
                                print(apiError) })
        }
    }

    func addingProduct(button: UIButton, products: [Product], viewforAlert: UIViewController){
        let product = products[button.tag]
        SVProgressHUD.show()
        if !Order.hasCurrentOrder {
            OrderApiClient.createOrder({ order in
                Order.currentOrder = order
                self.createProductInCart(product: product, quantidade: 1, viewforAlert: viewforAlert)
            }, failure: { apiError in
                AlertControllerHelper.showApiErrorAlert("Erro", message: apiError.errorMessage(), view: viewforAlert, handler: nil)
            })
        } else {
            let idForVariant = fetchProductInCart(product: product)
            if(idForVariant != -1){
                addProductToCart(idForVariant: idForVariant, product: product, quantidade: 1, viewforAlert: viewforAlert)
            }else{
                createProductInCart(product: product, quantidade: 1, viewforAlert: viewforAlert)
            }
        }
    }
    
    func addingProduct(product:Product, quantidade: Int, viewforAlert: UIViewController){
        SVProgressHUD.show()
        if !Order.hasCurrentOrder {
            OrderApiClient.createOrder({ order in
                Order.currentOrder = order
                self.createProductInCart(product: product, quantidade: quantidade, viewforAlert: viewforAlert)
            }, failure: { apiError in
                AlertControllerHelper.showApiErrorAlert("Erro", message: apiError.errorMessage(), view: viewforAlert, handler: nil)
            })
        } else {
            let idForVariant = fetchProductInCart(product: product)
            if(idForVariant != -1){
                addProductToCart(idForVariant: idForVariant, product: product, quantidade: quantidade, viewforAlert: viewforAlert)
            }else{
                createProductInCart(product: product, quantidade: quantidade, viewforAlert: viewforAlert)
            }
        }
    }
    
    func addProductToCart(idForVariant: Int, product: Product, quantidade: Int, viewforAlert: UIViewController){
        if let current = Order.currentOrder {
            if let idForRequest = current.number {
                var quantidadeNaLista: Int?
                for item in current.lineItems{
                    if(item.variant_id == product.id){
                        quantidadeNaLista = item.quantity!
                    }
                }
                var data = URLRequestParams()
                data["line_item[quantity]"] = quantidadeNaLista!+quantidade
                CartApiClient.updateLineItem(idForRequest, lineItemID: idForVariant, data: data, success: {
                    order in
                    SVProgressHUD.dismiss()
                    AlertControllerHelper.showApiSuccessAlert("Sucesso", message: "Produto adicionado no carrinho", view: viewforAlert, handler: nil)
                }, failure: { apiError in
                    AlertControllerHelper.showApiErrorAlert("Erro", message: apiError.errorMessage(), view: viewforAlert, handler: nil)
                    SVProgressHUD.dismiss()
                })
            }
        }
    }
    
    func createProductInCart(product: Product, quantidade: Int, viewforAlert: UIViewController){
        if let current = Order.currentOrder {
            if let id = current.number {
                var data = URLRequestParams()
                data["line_item[variant_id]"] = product.id
                data["line_item[quantity]"] = quantidade
                CartApiClient.addLineItem(id, data: data, success: {
                    order in
                    SVProgressHUD.dismiss()
                    AlertControllerHelper.showApiSuccessAlert("Sucesso", message: "Produto adicionado no carrinho", view: viewforAlert, handler: nil)
                }, failure: { apiError in
                    AlertControllerHelper.showApiErrorAlert("Erro", message: apiError.errorMessage(), view: viewforAlert, handler: nil)
                    SVProgressHUD.dismiss()
                })
            }
        }
    }
    
    func fetchProductInCart(product: Product) -> Int{
        if let current = Order.currentOrder {
            if (!current.lineItems.isEmpty){
                for item in current.lineItems {
                    if(item.variant_id == product.id){
                        return item.id!
                    }
                }
            }
        }
        return -1
    }
    

}
