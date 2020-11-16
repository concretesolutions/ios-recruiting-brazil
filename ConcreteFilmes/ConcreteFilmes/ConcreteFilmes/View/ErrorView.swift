//
//  ErrorView.swift
//  ConcreteFilmes
//
//  Created by Luis Felipe Tapajos on 14/11/2020.
//  Copyright © 2020 Luis Felipe Tapajos. All rights reserved.
//

import UIKit

class ErrorView {
    
    static let shared = ErrorView()
    
    func loadView(view: UIView) -> UIView {
        
        let errorView = UIView(frame: view.frame)
        
        //Image
        let innerImage = UIImageView()
        innerImage.frame = CGRect(x: (view.frame.size.width/2)-20 , y: 130, width: 105, height: 105)
        innerImage.image = UIImage(named: "error_icon")
        innerImage.sizeToFit()
        
        //Label
        let innerLabel = UILabel()
        innerLabel.textColor = UIColor.black
        innerLabel.frame = CGRect(x: 90, y: 200, width: view.frame.size.width-50, height: 100)
        innerLabel.textAlignment = .center
        innerLabel.text = "Ocorreu um erro. Por favor tente novamente."
        innerLabel.backgroundColor = UIColor.clear
        innerLabel.numberOfLines = 0
        innerLabel.sizeToFit()
        
        //View Center
        let innerView = UIView()
        innerView.backgroundColor = UIColor.white
        //innerView.layer.cornerRadius = 10
        innerView.frame = CGRect(x: 0, y: 130, width: view.frame.size.width, height: view.frame.size.height - 130)
        
        //Add Image
        innerView.addSubview(innerImage)
        
        //Add Label
        innerView.addSubview(innerLabel)
        
        //Add Inner View
        errorView.addSubview(innerView)
        
        return errorView
    }
    
}
