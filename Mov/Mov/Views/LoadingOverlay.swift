//
//  LoadingOverlay.swift
//  Mov
//
//  Created by Allan on 15/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

public class LoadingOverlay{
    
    private var overlayView : UIView!
    private var activityIndicator : UIActivityIndicatorView!
    
    static let shared: LoadingOverlay = LoadingOverlay()
    
    init(){
        self.overlayView = UIView()
        self.overlayView.frame = UIScreen.main.bounds
        self.overlayView.backgroundColor = UIColor.clear
        self.activityIndicator = UIActivityIndicatorView()
        
        let activityView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        activityView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        activityView.clipsToBounds = true
        activityView.layer.cornerRadius = 10
        activityView.layer.zPosition = 1
        activityView.center = self.overlayView.center
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = CGPoint(x: activityView.bounds.width / 2, y: activityView.bounds.height / 2)
        activityIndicator.style = .whiteLarge
        activityView.addSubview(activityIndicator)
        overlayView.addSubview(activityView)
    }
    
    public func showOverlay() {
        
        if let currentWindow = UIApplication.shared.keyWindow{
            overlayView.center = currentWindow.center
            currentWindow.addSubview(overlayView)
        }
        activityIndicator.startAnimating()
    }
    
    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}
