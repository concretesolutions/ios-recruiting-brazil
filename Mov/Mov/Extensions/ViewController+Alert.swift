//
//  ViewController+Alert.swift
//  Mov
//
//  Created by Allan on 10/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func showMessage(_ titulo: String?, mensagem: String?, completion: (() -> Void)?){
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                completion?()
            }))
            
            self.present(alert, animated: true, completion: nil)
            alert.view.tintColor = Constants.Colors.blue
        }
    }
}
