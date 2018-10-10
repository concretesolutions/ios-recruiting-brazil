//
//  BaseViewController.swift
//  Mov
//
//  Created by Allan on 03/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var currentTitle: String?
    
    //MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = " "
        self.setTitleView(nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTitleView(currentTitle)
    }
    
    //MARK: - Interface

    func setupInterface(){
        
    }
    
    private func setTitleView(_ text: String?){
        
        if text == nil{
            navigationItem.titleView = nil
            return
        }
        
        let lblTitle = UILabel()
        lblTitle.text = text
        lblTitle.textColor = UIColor.black
        lblTitle.font = UIFont.init(name: "Futura-Medium", size: 17.0)!
        lblTitle.sizeToFit()
        navigationItem.titleView = lblTitle
    }

}
