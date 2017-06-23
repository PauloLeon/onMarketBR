//
//  ProductViewModels.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 23/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit

public final class ProductViewModel {
    
    public let product: Product
    public var productImage: UIImageView!
    public let productName: String!
    public let productPrice: String!
    public let productTotal: String!
    public var quantidadeView: Double
    
    public init(product: Product){
        self.product = product
        self.productName = self.product.name
        self.productPrice = self.product.display_price
        self.productTotal  = self.product.display_price
        let imageName = "toddy"
        if let image = UIImage(named: imageName){
           self.productImage.sd_setImage(with: URL(string:product.thumbnailURL!), placeholderImage: image)
        }
        self.quantidadeView = 1
    }
    
    func getQuantidadeForView() -> String{
        return "\(Int(quantidadeView))"
    }
    
    func getQuantidadeTotalForView() -> String{
        return "R$\(self.quantidadeView * self.product.price!)"
    }
}

