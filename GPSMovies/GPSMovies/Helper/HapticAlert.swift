//
//  HapticAlert.swift
//  GPSMovies
//
//  Created by Gilson Pitanga Dos Santos on 07/06/19.
//  Copyright © 2019 Gilson Santos. All rights reserved.
//

import UIKit

class HapticAlert {
    class func hapticReturn(style: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}
