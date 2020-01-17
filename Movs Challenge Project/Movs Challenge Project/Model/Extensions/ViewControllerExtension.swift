//
//  ViewControllerExtension.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 16/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

extension UIViewController {
    func setCustomNavigationBar(title: String, color: UIColor) {
        let largeTitelTextAttributes = [NSAttributedString.Key.foregroundColor: color]
        navigationController?.navigationBar.largeTitleTextAttributes = largeTitelTextAttributes as [NSAttributedString.Key : Any]
        
        let titelTextAttributes = [NSAttributedString.Key.foregroundColor: color]
        navigationController?.navigationBar.titleTextAttributes = titelTextAttributes as [NSAttributedString.Key : Any]
        
        navigationItem.title = title
    }
}
