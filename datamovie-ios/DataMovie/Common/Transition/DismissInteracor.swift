//
//  DismissInteracor.swift
//  DataMovie
//
//  Created by Andre on 18/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class DismissInteracor: UIPercentDrivenInteractiveTransition {
    
    private var shouldCompleteTransition: Bool = false
    var isInProgress: Bool = false
    var viewControllerToAttach: UIViewController? {
        didSet {
            setupCloseGesture()
        }
    }
    
}

//MARK: - Gesture -

extension DismissInteracor {
    
    private func setupCloseGesture() {
        let closeGesture = UIPanGestureRecognizer(target: self, action: #selector(handleCloseGesture(_:)))
        viewControllerToAttach?.view.addGestureRecognizer(closeGesture)
    }
    
    @objc private func handleCloseGesture(_ gesture : UIPanGestureRecognizer) {
        
        if !isInProgress {
            let gestureLocation = gesture.location(in: gesture.view?.superview)
            if  gestureLocation.y > 100 {
                return
            }
        }
    
        let percentThreshold: CGFloat = 0.5
        
        let translation = gesture.translation(in: gesture.view?.superview)
        let verticalMovement = translation.y / (viewControllerToAttach?.view.bounds.height ?? 0)

        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        switch gesture.state {
        case .began:
            isInProgress = true
            viewControllerToAttach?.dismiss(animated: true, completion: nil)
            break
        case .changed:
            shouldCompleteTransition = progress > percentThreshold
            update(progress)
            break
        case .cancelled:
            isInProgress = false
            cancel()
            break
        case .ended:
            isInProgress = false
            shouldCompleteTransition ? finish() : cancel()
            break
        default:
            return
        }
    }
    
}
