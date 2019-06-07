//
//  SplashScreenViewController.swift
//  Cineasta
//
//  Created by Tomaz Correa on 31/05/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var splashImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    
}

// MARK: - LIFE CYCLE -
extension SplashScreenViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.showAppName()
    }
}

// MARK: - AUX METHODS -
extension SplashScreenViewController {
    private func showAppName() {
        self.appNameLabel.center.x -= view.bounds.width
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: { [unowned self] in
            self.appNameLabel.center.x += self.view.bounds.width
            }, completion: { [unowned self] _ in
                self.goToHome()
        })
    }
    
    private func goToHome() {
        UIView.animate(withDuration: 0.5, delay: 2.0, animations: { [unowned self] in
            self.splashImageView.center.y -= self.view.bounds.height
            self.appNameLabel.alpha = 0
        }, completion: { [unowned self] _ in
            self.performSegue(withIdentifier: Constants.Segues.showHome, sender: nil)
        })
    }
}
