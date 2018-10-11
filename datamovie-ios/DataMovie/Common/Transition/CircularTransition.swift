//
//  CircularTransition.swift
//  CircularTransition
//
//  Created by Training on 26/08/2016.
//  Copyright © 2016 Training. All rights reserved.
//

import UIKit

protocol CircularAnimatorDelegate: class {
    func transitionWillStartWith(animator: CircularTransition)
    func transitionDidEndWith(animator: CircularTransition)
}

class CircularTransition: NSObject {

    private var circle: UIView = UIView()
    private var circleColor: UIColor
    private var viewBackgroundColor: UIColor
    private var duration: TimeInterval
    private var startingPoint: CGPoint {
        didSet {
            circle.center = startingPoint
        }
    }
    
    var transitionMode: TransitionMode = .present
    
    weak var fromDelegate: CircularAnimatorDelegate?
    weak var toDelegate: CircularAnimatorDelegate?
    
    init(startingPoint: CGPoint = .zero, circleColor: UIColor = .white, viewBackgroundColor: UIColor = .black, duration: TimeInterval = 0.4) {
        self.startingPoint = startingPoint
        self.circleColor = circleColor
        self.viewBackgroundColor = viewBackgroundColor
        self.duration = duration
    }
    
}

extension CircularTransition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        fromDelegate?.transitionWillStartWith(animator: self)
        toDelegate?.transitionWillStartWith(animator: self)
        
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: .to) {
                
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                circle = UIView()
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = .identity
                    self.circle.backgroundColor = self.viewBackgroundColor
                    presentedView.transform = .identity
                    presentedView.center = viewCenter
                    
                },completion: { _ in
                    self.circle.removeFromSuperview()
                    presentedView.alpha = 1
                    self.toDelegate?.transitionDidEndWith(animator: self)
                    self.fromDelegate?.transitionDidEndWith(animator: self)
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            }
            
        } else if transitionMode == .dismiss {
            if let returningView = transitionContext.view(forKey: .from) {
                
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                returningView.alpha = 0
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.backgroundColor = self.circleColor
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.center = self.startingPoint
                    
                    containerView.insertSubview(returningView, belowSubview: returningView)
                    containerView.insertSubview(self.circle, belowSubview: returningView)
                    
                    }, completion: { _ in
                        if !transitionContext.transitionWasCancelled {
                            returningView.center = viewCenter
                            returningView.removeFromSuperview()
                            self.circle.removeFromSuperview()
                        } else {
                            returningView.alpha = 1
                        }
                        self.toDelegate?.transitionDidEndWith(animator: self)
                        self.fromDelegate?.transitionDidEndWith(animator: self)
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                        
                })
            }
        }
    }
}

//MARK: - Frame setup -

extension CircularTransition {
    
    private func frameForCircle (withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startPoint:CGPoint) -> CGRect {
        
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        
        let offestVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offestVector, height: offestVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
        
    }
    
}
