//
//  RightCollectionViewController.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 31/05/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit
import SVProgressHUD


private let reuseIdentifier = "Cell"
private let totalReuseIdentifier = "TotalCell"


class RightCollectionViewController: UICollectionViewController {
    fileprivate let itemsPerRow: CGFloat = 1
    var currentOrder: Order?
    var isLoading = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        SVProgressHUD.show()
        fetchOrders()
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
        if (isLoading){
            return 0
        }else{
            return (self.currentOrder?.lineItems.count)! + 1
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(isLoading){
            //wait bitch
        }else{
            if((indexPath.row) == collectionView.numberOfItems(inSection: 0) - 1){
                let cellFinal = collectionView.dequeueReusableCell(withReuseIdentifier: totalReuseIdentifier, for: indexPath) as! TotalCarrinhoCollectionViewCell
                cellFinal.backgroundColor = UIColor.white
                cellFinal.frame.size.height = 122
                cellFinal.carrinhoTotal.text = self.currentOrder?.display_item_total
                cellFinal.carrinhoFrete.text = self.currentOrder?.display_ship_total
                cellFinal.carrinhoPrecoFinal.text = self.currentOrder?.display_total
                cellFinal.carrinhoEconomia.text = "not today"
                roundCells(cell: cellFinal)
                return cellFinal
            }
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CarrinhoCollectionViewCell
            
            cell.backgroundColor = UIColor.white
            let imageName = "toddy"
            if let image = UIImage(named: imageName){
                cell.produtoImage.image =  image
            }
            if let order = self.currentOrder{
                cell.produtoName.text = order.lineItems[indexPath.row].name
                cell.produtoDesc.text = order.lineItems[indexPath.row].desc
                cell.produtoPreco.text = order.lineItems[indexPath.row].single_display_amount
                if let quantidade = order.lineItems[indexPath.row].quantity{
                    cell.produtoQuantidade.text = String(describing: quantidade)
                    print(String(describing: quantidade))
                }
                if let total = order.lineItems[indexPath.row].total{
                    cell.precoFinal.text = "R$\(String(describing: total))"
                }
            }
            roundCells(cell: cell)
            return cell
       }
        let cellFinal = collectionView.dequeueReusableCell(withReuseIdentifier: totalReuseIdentifier, for: indexPath) as! TotalCarrinhoCollectionViewCell
        return cellFinal
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
    
    func fetchOrders(){
        OrderApiClient.current({ currentOrder in
            self.currentOrder = currentOrder
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
    
    func showAlert(_ title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: handler)
        ac.addAction(ok)
        present(ac, animated: true, completion: nil)
    }

}
