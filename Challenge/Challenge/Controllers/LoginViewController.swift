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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        self.userNameTextField.addBottomBorderWithColor(color: .black, width: 1)
        self.passwordTextField.addBottomBorderWithColor(color: .black, width: 1)
        self.movies = Movie.fetchSortedByDate()
        for movie in self.movies {
            print(movie.name)
        }
    }
    
    @IBAction func unwindToLogin(segue:UIStoryboardSegue) { }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
    
    @IBAction func signUp(_ sender: Any) {
        User.user.requestToken(onSuccess: { (token) in
            self.performSegue(withIdentifier: "sign", sender: nil)
        }) { (error) in
            print(error)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sign" {
            if let vc = segue.destination as? SignUpViewController {
                vc.token = User.user.token
            }
        }
    }
    
}

