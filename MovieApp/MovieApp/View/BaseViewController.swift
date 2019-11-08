//
//  BaseViewController.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//
import UIKit
import Lottie

class BaseViewController: UIViewController {
    
    let starAnimationView = AnimationView()
    let starAnimation = Animation.named("loading")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func startAnimating() {
        starAnimationView.isHidden = false
        starAnimationView.animation = starAnimation
        starAnimationView.frame =  CGRect(x: 0, y: 0, width: 100, height: 100)
        starAnimationView.center = self.view.center
        starAnimationView.loopMode = .loop
        starAnimationView.play()
        self.view.addSubview(starAnimationView)
    
        
    }
    func stopAnimating() {
        starAnimationView.stop()
        starAnimationView.isHidden = true
        
        
    }
    
    func showErros(error: NSError) {
        let alert: UIAlertController = UIAlertController(title: "Erro :(", message: error.localizedDescription, preferredStyle: .alert)
        
        let actionOk: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }

}

