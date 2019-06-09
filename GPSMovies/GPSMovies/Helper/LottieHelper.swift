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
    case searchEmpty = "search"
}

class LottieHelper {
    
    class func showAnimateion(for type: TypeAnimation, lottieView: AnimationView, in contaierView: UIView) {
        let animation = Animation.named(type.rawValue)
        lottieView.animation = animation
        contaierView.isHidden = false
        lottieView.alpha = 0
        lottieView.isHidden = false
        UIView.animate(withDuration: 0.4, animations: {
            lottieView.alpha = 1
        }) { (_) in
            lottieView.play()
        }
    }
    
    class func hideAnimateion(lottieView: AnimationView, in contaierView: UIView) {
        UIView.animate(withDuration: 0.4, animations: {
            contaierView.alpha = 0
        }) { (_) in
            lottieView.stop()
            lottieView.isHidden = true
            contaierView.isHidden = true
            contaierView.alpha = 1
        }
    }
}
