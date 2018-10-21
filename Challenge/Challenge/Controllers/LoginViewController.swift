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
        Movie.getPopularMovies(pageToRequest: 1, onSuccess: { (movies) in
            
        }) { (error) in
            
        }
        
    }

    @IBAction func loginAction(_ sender: Any) {
        if !(userNameTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)! {
            User.user.login(username: userNameTextField.text!, password: passwordTextField.text!, onSuccess: { (result) in
                User.user.getAccountDetails(onSuccess: { (result) in
                    print("User ID: \(String(describing: User.user.userId!))")
                }, onFailure: { (error) in
                    print(error)
                })
            }) { (error) in
                print(error)
            }
        }
    }
    
}

