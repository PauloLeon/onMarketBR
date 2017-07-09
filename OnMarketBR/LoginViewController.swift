//
//  LoginViewController.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 02/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit
import BubbleTransition
import Lottie

class LoginViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var close: UIButton!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mostrarSenha: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    let transition = BubbleTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RoundedHelper.roundButtons(button: signInButton)
        RoundedHelper.roundButtons(button: signUpButton)
        loadAnimation()
    }
    
    @IBAction func signIn(_ sender: Any) {
        view.endEditing(true)
        if let email = email.text{
            if let senha = senha.text{
                if (email != "" || senha != "") {
                    sendToAPI(email: prepareString(string: email).lowercased(), senha: prepareString(string: senha))
                }
            }
        }
    }
    
    @IBAction func close(_ sender: Any) {
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRegister"{
            let controller = segue.destination
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .custom
        }
    }
    
    func sendToAPI(email: String, senha: String){
        var data = URLRequestParams()
        data["email"] = email
        data["password"] = senha
        UserApiClient.signin(data,
                             success: {
                                user in print("sucesso") },
                             failure: { apiError in
                                        AlertControllerHelper.showApiErrorAlert("Erro", message: apiError.errorMessage(), view: self, handler: nil) })
    }
    
    func prepareString(string: String) -> String{
       let returnString =  string.trimmingCharacters(in: .whitespacesAndNewlines)
       return returnString
    }
    
    // MARK: Animation
    
    func loadAnimation(){
        let animationView = LOTAnimationView(name: "PinJump")
        animationView.frame = CGRect(x: 90, y: 10, width: 200, height: 200)
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        self.view.addSubview(animationView)
        animationView.play()
    }

    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = self.signUpButton.center
        transition.bubbleColor = self.signUpButton.backgroundColor!
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = self.signUpButton.center
        transition.bubbleColor = self.signUpButton.backgroundColor!
        return transition
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
    }
}
