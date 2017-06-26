//
//  AddAddressViewController.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 26/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit

class AddAddressViewController: UIViewController{

    @IBOutlet weak var destinatario: UITextField!
    @IBOutlet weak var nomeLocal: UITextField!
    @IBOutlet weak var CEP: UITextField!
    @IBOutlet weak var endereco: UITextField!
    @IBOutlet weak var bairro: UITextField!
    @IBOutlet weak var numero: UITextField!
    @IBOutlet weak var complemento: UITextField!
    @IBOutlet weak var addLocalBtn: UIButton!
    var round = RoundedHelper()
    var addressCacheHelper = AddressCacheHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        RoundedHelper.roundButtons(button: addLocalBtn)
        setColorPlaceholder()
    }

    @IBAction func addLocal(_ sender: Any) {
        addressCacheHelper.save(fullname: nomeLocal.text!, address1: endereco.text!, address2: complemento.text!, city: "Belem", zipcode: CEP.text!, number: numero.text!)
    }
    
    func setColorPlaceholder(){
        destinatario.attributedPlaceholder = NSAttributedString(string: "Destinatário", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
        nomeLocal.attributedPlaceholder = NSAttributedString(string: "Nome do Local", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
        CEP.attributedPlaceholder = NSAttributedString(string: "CEP", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
        endereco.attributedPlaceholder = NSAttributedString(string: "Endereço", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
        bairro.attributedPlaceholder = NSAttributedString(string: "Bairro", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
        numero.attributedPlaceholder = NSAttributedString(string: "Número", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
        complemento.attributedPlaceholder = NSAttributedString(string: "Complemento", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
    }
    
    func showError() {
        showAlert("Campo Vazio", message: "Você deve preencher todos os campos", handler: nil)
    }
    
    func showAlert(_ title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: handler)
        ac.addAction(ok)
        self.present(ac, animated: true, completion: nil)
    }
    
}
