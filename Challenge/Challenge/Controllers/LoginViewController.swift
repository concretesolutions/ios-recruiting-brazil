//
//  ViewController.swift
//  Challenge
//
//  Created by Sávio Berdine on 20/10/18.
//  Copyright © 2018 Sávio Berdine. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loginAction(_ sender: Any) {
        if !(userNameTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)! {
            User.user.login(username: userNameTextField.text!, password: passwordTextField.text!, onSuccess: { (result) in
                
            }) { (error) in
                print(error)
            }
        }
    }
    
}

