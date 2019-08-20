//
//  Alerta.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 20/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import Foundation
import UIKit

class Alerta {
    
    static func alerta (_ title : String, msg : String, view: UIViewController ) {
        let alert = UIAlertController(title: title, message : msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        view.present(alert, animated: true, completion: nil)
        
    }
    
}
