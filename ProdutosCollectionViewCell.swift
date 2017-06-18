//
//  ProdutosCollectionViewCell.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 30/05/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit

class ProdutosCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var produtoImage: UIImageView!
    @IBOutlet weak var produtoName: UILabel!
    @IBOutlet weak var produtoDesc: UILabel!
    @IBOutlet weak var lblEconomia: UILabel!
    @IBOutlet weak var precoProduto: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var produtoQuantidade: UILabel!
    @IBOutlet weak var addCart: UIButton!

}
