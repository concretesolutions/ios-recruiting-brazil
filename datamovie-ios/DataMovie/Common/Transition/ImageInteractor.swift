//
//  ImageInteractor.swift
//  CustomNavigationAnimations-Complete
//
//  Created by Sam Stone on 29/09/2017.
//  Copyright © 2017 Sam Stone. All rights reserved.
//

import UIKit

class ImageInteractor : UIPercentDrivenInteractiveTransition {
    
    private var shouldCompleteTransition: Bool = false
    var isInProgress: Bool = false
    var navControllerToAttach: UINavigationController? {
        didSet {
            setupBackGesture()
        }
    }
    
}

//MARK: - Gesture -

extension ImageInteractor {
    
    private func setupBackGesture() {
        let swipeBackGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleBackGesture(_:)))
        swipeBackGesture.edges = .left
        navControllerToAttach?.view.addGestureRecognizer(swipeBackGesture)
    }
    
    @objc private func handleBackGesture(_ gesture : UIScreenEdgePanGestureRecognizer) {
        
        let viewTranslation = gesture.translation(in: gesture.view?.superview)
        let progress = viewTranslation.x / (navControllerToAttach?.view.frame.width ?? 0)
        
        switch gesture.state {
        case .began:
            isInProgress = true
            navControllerToAttach?.popViewController(animated: true)
            break
        case .changed:
            shouldCompleteTransition = progress > 0.5
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
