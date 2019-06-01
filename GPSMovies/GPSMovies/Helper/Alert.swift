//
//  Alert.swift
//  GitHubRepository
//
//  Created by Gilson Santos on 28/11/18.
//  Copyright © 2018 Gilson Santos. All rights reserved.
//

import UIKit

class Alert {
    
    class func showAlert(title:String, message:String, controller:UIViewController){
        let notification = UIAlertController(title: title, message: message, preferredStyle: .alert)
        notification.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        controller.present(notification, animated: true, completion: nil)
    }
    
}
