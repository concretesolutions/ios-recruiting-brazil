//
//  ImageAnimatorTransition.swift
//  DataMovie
//
//  Created by Andre on 02/05/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

protocol ImageAnimatorDelegate: class {
    func transitionWillStartWith(animator: ImageAnimatorTransition)
    func transitionDidEndWith(animator: ImageAnimatorTransition)
    func referenceImageView(for animator: ImageAnimatorTransition) -> UIImageView?
    func referenceImageViewFrameInTransitioningView(for animator: ImageAnimatorTransition) -> CGRect?
}

class ImageAnimatorTransition : NSObject {
    
    private var transitionImageView: UIImageView?
    
    weak var fromDelegate: (ImageAnimatorDelegate & UINavigationControllerDelegate)?
    weak var toDelegate: ImageAnimatorDelegate?
    
    var transitionMode: TransitionMode = .push
    
}

extension ImageAnimatorTransition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        guard
            let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from),
            let toReferenceImageView = toDelegate?.referenceImageView(for: self),
            let fromReferenceImageView = fromDelegate?.referenceImageView(for: self),
            let imageViewInitialFrame = (transitionMode == .push) ? fromDelegate?.referenceImageViewFrameInTransitioningView(for: self) : toDelegate?.referenceImageViewFrameInTransitioningView(for: self),
            let imageViewFinalFrame = (transitionMode == .push) ? toDelegate?.referenceImageViewFrameInTransitioningView(for: self) : fromDelegate?.referenceImageViewFrameInTransitioningView(for: self),
            let referenceImage = (transitionMode == .push) ? fromReferenceImageView.image : toReferenceImageView.image
        else { return }
        
        self.fromDelegate?.transitionWillStartWith(animator: self)
        self.toDelegate?.transitionWillStartWith(animator: self)
        
        toVC.view.alpha = 0
        
        toReferenceImageView.isHidden = true
        fromReferenceImageView.isHidden = true
        
        containerView.addSubview(toVC.view)
        
        createTrasitionImage(referenceImage: referenceImage, frame: imageViewInitialFrame)
        if let transitionImageView = self.transitionImageView {
            containerView.addSubview(transitionImageView)
        }
        
        toVC.view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.0, options: [.transitionCrossDissolve, .curveEaseInOut], animations: {
                        
                fromVC.view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                toVC.view.transform = CGAffineTransform.identity
                
                self.transitionImageView?.frame = imageViewFinalFrame
                
                toVC.view.alpha = 1.0
                fromVC.view.alpha = 0.0
                fromVC.tabBarController?.tabBar.alpha = 0
                        
        }, completion: { completed in
                        
            fromVC.view.transform = CGAffineTransform.identity
        
            self.transitionImageView?.removeFromSuperview()
            self.transitionImageView = nil
        
            toReferenceImageView.isHidden = false
            fromReferenceImageView.isHidden = false
            
            if transitionContext.transitionWasCancelled {
                toVC.view.transform = CGAffineTransform.identity
            }
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        
            self.toDelegate?.transitionDidEndWith(animator: self)
            self.fromDelegate?.transitionDidEndWith(animator: self)
                        
        })
    }

}

extension ImageAnimatorTransition {
    
    private func createTrasitionImage(referenceImage: UIImage, frame: CGRect) {
        if self.transitionImageView == nil {
            let transitionImageView = UIImageView(image: referenceImage)
            transitionImageView.contentMode = .scaleAspectFit
            transitionImageView.clipsToBounds = true
            transitionImageView.frame = frame
            self.transitionImageView = transitionImageView
        }
    }
    
}





