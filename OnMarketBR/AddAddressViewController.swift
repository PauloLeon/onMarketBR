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
    var style: Int16?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        RoundedHelper.roundButtons(button: addLocalBtn)
        setColorPlaceholder()
    }

    @IBAction func addLocal(_ sender: Any) {
        if verify(fullname: nomeLocal.text!, address1: endereco.text!, zipcode: CEP.text!, number: numero.text!) {
            if let styleCustom = style{
               addressCacheHelper.save(fullname: nomeLocal.text!, address1: endereco.text!, address2: complemento.text ?? "", city: "Belem", zipcode: CEP.text!, number: numero.text!, style: styleCustom)
                self.navigationController?.popViewController(animated: true)
            }
        }
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
    
    func verify(fullname: String, address1: String, zipcode: String, number: String) -> Bool{
        if fullname.isEmpty{
            showError(campo: "Nome do Local")
            return false
        }else if address1.isEmpty{
            showError(campo: "Endereço")
            return false
        }else if zipcode.isEmpty{
            showError(campo: "CEP")
            return false
        }else if number.isEmpty{
            showError(campo: "Número")
            return false
        }
        return true
    }
    
    func showError(campo: String) {
        showAlert("Campo Vazio", message: "Você deve preencher o campo \(campo)", handler: nil)
    }
    
    func showSucess() {
        showAlert("Endereço Cadastrado", message: "você cadastrou esse endereço com sucesso", handler: nil)
    }
    
    func showAlert(_ title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: handler)
        ac.addAction(ok)
        self.present(ac, animated: true, completion: nil)
    }
    
}
