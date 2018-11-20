//
//  IndicatorView.swift
//  ActivityIndicatorExtension
//
//  Created by Renan Germano on 15/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class IndicatableView: UIView, Indicatable {
    
    // MARK: - Properties
    
    private var activityIndicator: UIActivityIndicatorView
    private var textLabel: UILabel?
    private var backgroundView: UIView
    
    var isShowing: Bool { return self.activityIndicator.isAnimating }
    
    // MARK: - Initializers
    
    init(style: UIActivityIndicatorView.Style = .whiteLarge,
         color: UIColor = .black,
         text: String? = nil,
         backgroundEffect: UIBlurEffect.Style? = .light,
         frame: CGRect = .zero) {
        
        // Creating Activity Indicator
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.color = color
        self.activityIndicator = activityIndicator
        
        // Creating Text Label
        var label: UILabel?
        if let text = text {
            label = UILabel()
            label?.text = text
            label?.numberOfLines = 0
            label?.textAlignment = .center
            label?.textColor = color
        }
        self.textLabel = label
        
        // Creating Background View
        var backgroundView: UIView!
        if let backgroundEffect = backgroundEffect {
            let visualEffectView = UIVisualEffectView.init(effect: UIBlurEffect(style: backgroundEffect))
            backgroundView = visualEffectView
            self.backgroundView = backgroundView
        } else {
            backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            self.backgroundView = backgroundView
        }
        
        super.init(frame: frame)
        
        self.addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Aux functions
    private func addConstraints() {
        
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.textLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding Constraints
        self.addSubview(self.backgroundView)
        
        if let effectView = (self.backgroundView as? UIVisualEffectView)?.contentView {
            effectView.addSubview(self.activityIndicator)
            self.activityIndicator.centerXAnchor.constraint(equalTo: effectView.centerXAnchor).isActive = true
            self.activityIndicator.centerYAnchor.constraint(equalTo: effectView.centerYAnchor).isActive = true
            
            if let label = self.textLabel {
                effectView.addSubview(label)
                label.leftAnchor.constraint(equalTo: effectView.leftAnchor, constant: 0).isActive = true
                label.rightAnchor.constraint(equalTo: effectView.rightAnchor, constant: 0).isActive = true
                label.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 0).isActive = true
                label.bottomAnchor.constraint(equalTo: effectView.bottomAnchor, constant: 0).isActive = true
            }
        } else {
            self.backgroundView.addSubview(self.activityIndicator)
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor).isActive = true
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.backgroundView.centerYAnchor).isActive = true
            
            if let label = self.textLabel {
                self.backgroundView.addSubview(label)
                label.leftAnchor.constraint(equalTo: self.backgroundView.leftAnchor, constant: 0).isActive = true
                label.rightAnchor.constraint(equalTo: self.backgroundView.rightAnchor, constant: 0).isActive = true
                label.topAnchor.constraint(equalTo: self.activityIndicator.bottomAnchor, constant: 0).isActive = true
                label.bottomAnchor.constraint(equalTo: self.backgroundView.bottomAnchor, constant: 0).isActive = true
            }
        }
    
        self.backgroundView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        self.backgroundView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
        self.backgroundView.isHidden = true
        
    }
    
    // MARK: - Indicatable Functions
    
    func showActivityIndicator() {
        self.activityIndicator.startAnimating()
        self.bringSubviewToFront(self.backgroundView)
        self.backgroundView.isHidden = false
    }
    
    func hideActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.backgroundView.isHidden = true
    }
    
}




