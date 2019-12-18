//
//  ViewController.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 06/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//


import UIKit
import CoreData
class ViewController: UIViewController {
    let table = FavoritesTableViewController()
    
    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .purple
        self.view = view
        self.addChild(table)
        self.view.addSubview(table.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

}

