//
//  CarrinhoCollectionViewCell.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 31/05/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit

class CarrinhoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var produtoImage: UIImageView!
    @IBOutlet weak var produtoName: UILabel!
    @IBOutlet weak var produtoDesc: UILabel!
    @IBOutlet weak var produtoPreco: UILabel!
    @IBOutlet weak var produtoQuantidade: UILabel!
    @IBOutlet weak var precoFinal: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
}
