//
//  RightCollectionViewController.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 31/05/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let totalReuseIdentifier = "TotalCell"


class RightCollectionViewController: UICollectionViewController {
    fileprivate let itemsPerRow: CGFloat = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if((indexPath.row) == collectionView.numberOfItems(inSection: 0) - 1){
            let cellFinal = collectionView.dequeueReusableCell(withReuseIdentifier: totalReuseIdentifier, for: indexPath) as! TotalCarrinhoCollectionViewCell
            cellFinal.backgroundColor = UIColor.white
            cellFinal.frame.size.height = 122
            cellFinal.carrinhoTotal.text = "R$ 45,40"
            cellFinal.carrinhoFrete.text = "R$ 45,40"
            cellFinal.carrinhoPrecoFinal.text = "R$ 45,40"
            cellFinal.carrinhoEconomia.text = "R$ 0,40"
            roundCells(cell: cellFinal)
            return cellFinal
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CarrinhoCollectionViewCell
        
        cell.backgroundColor = UIColor.white
        let imageName = "toddy"
        if let image = UIImage(named: imageName){
            cell.produtoImage.image =  image
        }
        cell.produtoName.text = "Achocolatado Toddy"
        cell.produtoDesc.text = "Pote 200g"
        cell.produtoPreco.text = "Unidade - R$ 4,61"
        cell.produtoQuantidade.text = "100"
        cell.precoFinal.text = "R$ 4,61"

        roundCells(cell: cell)
        return cell
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
}
