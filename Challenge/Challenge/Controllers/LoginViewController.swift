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
    
    var movies: [Movie] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TELA 1")
        
        
        
    }

    @IBAction func loginAction(_ sender: Any) {
        if !(userNameTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)! {
            User.user.login(username: userNameTextField.text!, password: passwordTextField.text!, onSuccess: { (result) in
                User.user.getAccountDetails(onSuccess: { (result) in
                    print("User ID: \(String(describing: User.user.userId!))")
                    print("Session ID: \(String(describing: User.user.sessionId!))")
                    self.performSegue(withIdentifier: "loginAccepted", sender: nil)
                    
//                    Movie.getFavoriteMovies(pageToRequest: 1, onSuccess: { (movies) in
//                        for element in movies {
//                            print(element.genre.read())
//                            element.genre.addObserver(self, using: { (vc, genre) in
//                                print(genre)
//                            })
//                        }
//                    }) { (error) in
//                        print(error)
//                    }
                }, onFailure: { (error) in
                    print(error)
                })
            }) { (error) in
                print(error)
            }
        }
    }
    
}

