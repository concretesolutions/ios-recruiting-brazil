//
//  ImportantActionButton.swift
//  Movs
//
//  Created by Gabriel D'Luca on 18/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class ImportantActionButton: UIButton {
    
    // MARK: - Variables
    
    private var circleLayer: ExpandableCircleLayer?
    
    // MARK: - Helpers
    
    private func animateHighlight() {
        UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 0.985, y: 0.985)
        })
    }
    
    private func animateUnhighlight() {
        UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        })
    }
    
    // MARK: - Touch Events
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.animateHighlight()
        
        guard let buttonTouches = event?.touches(for: self) else { return }
        if let touch = buttonTouches.first {
            self.circleLayer = ExpandableCircleLayer(toBounds: self.bounds, origin: touch.location(in: self), fillColor: UIColor(named: "palettePurple2"))
            self.layer.insertSublayer(self.circleLayer!, below: self.titleLabel?.layer)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.circleLayer?.removeAllAnimations()
        self.circleLayer?.removeFromSuperlayer()
        self.animateUnhighlight()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.circleLayer?.removeAllAnimations()
        self.circleLayer?.removeFromSuperlayer()
        self.animateUnhighlight()
    }
}
