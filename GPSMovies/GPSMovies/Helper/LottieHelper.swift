//
//  LottieHelper.swift
//  GPSMovies
//
//  Created by Gilson Santos on 08/06/19.
//  Copyright © 2019 Gilson Santos. All rights reserved.
//

import Foundation
import UIKit
import Lottie

enum TypeAnimation: String {
    case loading = "loading"
    case error = "error"
    case favorite = "favourite_app_icon"
}

class LottieHelper {
    
    class func showAnimateion(for type: TypeAnimation, in view: AnimationView) {
        let animation = Animation.named(type.rawValue)
        view.animation = animation
        view.alpha = 0
        view.isHidden = false
        UIView.animate(withDuration: 0.4, animations: {
            view.alpha = 1
        }) { (_) in
            view.play()
        }
    }
    
    class func hideAnimateion(in view: AnimationView) {
        UIView.animate(withDuration: 0.4, animations: {
            view.alpha = 0
        }) { (_) in
            view.stop()
            view.isHidden = true
        }
    }
}
