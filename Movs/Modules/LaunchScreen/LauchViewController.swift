//
//  LauchViewController.swift
//  Movs
//
//  Created by Joao Lucas on 21/10/20.
//

import UIKit
import Lottie

class LauchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAnimation()
    }
    
    private func setupAnimation() {
        let animationView = AnimationView(name: "34590-movie-theatre")
        animationView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        animationView.center = self.view.center
                
        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = 0.5
                
        view.addSubview(animationView)
        animationView.play()
    }

}
