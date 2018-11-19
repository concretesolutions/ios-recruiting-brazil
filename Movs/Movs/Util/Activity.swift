//
//  Activity.swift
//  Movs
//
//  Created by Victor Rodrigues on 16/11/18.
//  Copyright © 2018 Victor Rodrigues. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class Activity {
    
    static let shared = Activity()
    
    func showProgress(backgroundColor: UIColor, message: String) {
        let activityData = ActivityData(message: message, messageFont: UIFont.boldSystemFont(ofSize: 14), type: .ballSpinFadeLoader, color: #colorLiteral(red: 0.9674550891, green: 0.8083546758, blue: 0.3577282727, alpha: 1), backgroundColor: backgroundColor, textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, .none)
    }
    
    func stopProgress(){
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(.none)
    }
}
