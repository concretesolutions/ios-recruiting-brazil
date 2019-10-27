//
//  SplashViewController.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 25/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        startTimer()
    }
    
    private func configView() {
        view.backgroundColor = Colors.accent
        titleLabel.textColor = Colors.primary
    }
    
    private func startTimer() {
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(showHomeView), userInfo: nil, repeats: false)
    }
    
    @objc private func showHomeView() {
        let homeVC = HomeViewController()
        let homeNC = UINavigationController(rootViewController: homeVC)
        UIApplication.shared.keyWindow?.rootViewController = homeNC
    }
}
