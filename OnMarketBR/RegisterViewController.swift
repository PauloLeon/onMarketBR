//
//  RegisterViewController.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 02/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var close: UIButton!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var cpf: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var confirmarSenha: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RoundedHelper.roundButtons(button: signUp)
        setColorPlaceholder()
    }
    
    @IBAction func close(_ sender: Any) {
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func setColorPlaceholder(){
        nome.attributedPlaceholder = NSAttributedString(string: "Nome", attributes: [NSForegroundColorAttributeName:UIColor.white])
        cpf.attributedPlaceholder = NSAttributedString(string: "CPF", attributes: [NSForegroundColorAttributeName:UIColor.white])
        email.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName:UIColor.white])
        senha.attributedPlaceholder = NSAttributedString(string: "Senha", attributes: [NSForegroundColorAttributeName:UIColor.white])
        confirmarSenha.attributedPlaceholder = NSAttributedString(string: "Confirmar Senha", attributes: [NSForegroundColorAttributeName:UIColor.white])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
    }
    
    func requestData() -> URLRequestParams{
        var data = URLRequestParams()
        
        data["user[name]"] = nome.text! as AnyObject?
        data["user[email]"]     = email.text! as AnyObject?
        data["user[password]"]  = senha! as AnyObject?
        data["user[cpf]"]     = cpf.text! as AnyObject?
        
        return data
    }

}
