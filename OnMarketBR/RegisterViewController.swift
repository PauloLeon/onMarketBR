//
//  RegisterViewController.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 02/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var viewClose: UIView!
    @IBOutlet weak var close: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleView(view: viewClose)
    }
    
    func circleView(view: UIView) {
        view.layer.cornerRadius = 15.0
        view.layer.borderWidth = 15.0
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.masksToBounds = true
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
    }

}
