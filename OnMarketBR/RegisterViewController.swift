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
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
    }
    
    @IBAction func registerBtnClick(_ sender: Any) {
        verifyPassword()
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
    
    func sendToAPI(){
        let data = requestData()
        //segunda verificação se o data está correto
        if data.count > 0 {
            UserApiClient.signup(data,
                                success: {json in print("sucesso") },
                                 failure: { apiError in
                                    AlertControllerHelper.showApiErrorAlert("Erro", message: apiError.errorMessage(), view: self, handler: nil) })
        }
    }
    
    //popula o requestData
    func requestData() -> URLRequestParams{
        var data = URLRequestParams()
        if verifyParams(textField: nome) && verifyParams(textField: email) && verifyParams(textField: senha) && verifyParams(textField: cpf) {
            data["name"] = nome
            data["email"] = email
            data["senha"] = senha
            data["cpf"] = cpf
        }
        return data
    }
    
    //verifica se os parametros não estão vazios
    func verifyParams(textField: UITextField) -> Bool{
        guard let param =  textField.text else{
            AlertControllerHelper.showApiErrorAlert("Ops!", message: "Por favor, preencha todos os campos", view: self, handler: nil)
            return false
        }
        if !param.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            return true
        }
        AlertControllerHelper.showApiErrorAlert("Ops!", message: "Por favor, preencha todos os campos", view: self, handler: nil)
        return false
    }
    
    //verifica se a senha é maior que 6 caracteres e se foi as duas são iguais
    func verifyPassword(){
        guard let password1 = senha.text, let password2 = confirmarSenha.text else {
            return
        }
        if password1 == password2{
            if password1.characters.count<6 {
                AlertControllerHelper.showApiErrorAlert("Ops!Senha está muito curta!", message: "Por favor insira mais de 6 caracteres", view: self, handler: nil)
            }else{
                sendToAPI()
            }
        }else{
            AlertControllerHelper.showApiErrorAlert("Ops!Senhas Diferentes", message: "As senhas estão diferentes", view: self, handler: nil)
        }
    }
}
