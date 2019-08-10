//
//  LoopScrollLabel.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 10/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import Foundation
import UIKit

class LoopScrollLabel: UIView {
    private let animationDelay: Double = 2.0
    private let speedFactor: Int = 5
    
    @IBOutlet weak var label: UILabel!
    
    public func triggerAnimationIfNeeded() {
        guard let label = self.label else {
            return
        }
        
        DispatchQueue.main.async {
            let sizeThatFits = label.sizeThatFits(CGSize.zero)
            let widthDiff = sizeThatFits.width - self.frame.size.width
            if widthDiff > 0 {
                //self.animateLabelScroll(label, widthDiff)
            }
        }
    }
    
    func animateLabelScroll(_ label: UILabel, _ widthDiff: CGFloat) {
        self.removeAnimation()
        
        guard let labelText = label.text else {
            return
        }
        
        let originalFrame = label.frame
        let sizeThatFits = label.sizeThatFits(CGSize.zero)
        
        let animationDuration = TimeInterval(labelText.count / self.speedFactor)
        
        UIView.animate(withDuration: animationDuration, delay: self.animationDelay, options: [.curveLinear], animations: {
            label.frame = CGRect(x: originalFrame.origin.x - widthDiff, y: originalFrame.origin.y, width: sizeThatFits.width, height: originalFrame.size.height)
        }, completion: { _ in
            UIView.animate(withDuration: animationDuration, delay: self.animationDelay, options: [.curveLinear], animations: {
                label.frame = originalFrame
            }, completion: { _ in
                self.animateLabelScroll(label, widthDiff)
            })
        })
    }
    
    func removeAnimation() {
        self.layer.removeAllAnimations()
    }
}
