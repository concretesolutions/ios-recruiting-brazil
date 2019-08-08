//
//  BaseViewController.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {
    
    
    func showActivityIndicator() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func showPainelView(painelView:DisplayInformationView, contentView:UIView, description:String, typeReturn:GenericResult.typeReturn){
        DispatchQueue.main.async {
            painelView.isHidden = false
            painelView.fill(description: description, typeReturn: typeReturn)
            contentView.bringSubviewToFront(painelView)
        }
    }
    
    func hidePainelView(painelView:DisplayInformationView, contentView:UIView){
        DispatchQueue.main.async {
            painelView.isHidden = true
            contentView.sendSubviewToBack(painelView)
        }
    }
}
