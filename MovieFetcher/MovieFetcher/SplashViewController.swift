//
//  SplashViewController.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 27/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit
import Foundation

class SplashViewController: UIViewController {
    //MARK: - Variables
    lazy var appName:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingHead
        label.textColor = .white
        label.text = "Movs"
        label.font = label.font.withSize(80)
        label.adjustsFontSizeToFitWidth = true
        view.addSubview(label)
        return label
    }()
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hex: dao.concreteGray)
        setConstraints()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        fadeViewInThenOut(view: appName, delay: 0.5)
    }
    
    
    //MARK: - Complimentary methods
    func fadeViewInThenOut(view : UIView, delay: TimeInterval) {
        
        let animationDuration = 0.5
        
        // Fade out the view
        UIView.animate(withDuration: 0.75, animations: { () -> Void in
            view.alpha = 0
        }) { (Bool) -> Void in
            
            // After the animation completes, fade in the view after a delay
            UIView.animate(withDuration: animationDuration, delay: delay, options: .curveEaseInOut, animations: { () -> Void in
                view.alpha = 1
            },completion: nil)
        }
    }
    
    //MARK: - Constraints
    func setConstraints(){
        
        appName.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
        appName.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        appName.heightAnchor.constraint(equalToConstant: view.frame.height/3).isActive = true
        
        
    }
    
}
