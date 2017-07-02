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
    let cartHelper = CartHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        SVProgressHUD.show()
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
            RoundedHelper.roundCells(cell: cell)
            return cell
        }
        RoundedHelper.roundCells(cell: cell)
        return cell
    }
    
    func addingProduct(button: UIButton){
        cartHelper.addingProduct(button: button, products: self.products, viewforAlert: self)
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
            print(apiError)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "segueToDetail" {
            let detailCV = segue.destination as! ProdutoDetailViewController
            let cell = sender as! ProdutosCollectionViewCell
            let indexPaths = self.collectionView?.indexPath(for: cell)
            detailCV.productViewModel = ProductViewModel(product: self.products[(indexPaths?.row)!])
            print("")
        }
    }
}
