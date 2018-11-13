//
//  UIView+Utils.swift
//  Wonder
//
//  Created by Marcelo on 07/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

enum ErrorType : String {
    case internet
    case loading
    case business
}

extension UIView {
    
    
    // MARK: - Error Handler
    func showErrorView(errorHandlerView: UIView, errorType: ErrorType, errorMessage: String) {

        errorHandlerView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        errorHandlerView.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        errorHandlerView.tag = 1001
        if errorType.rawValue == "internet" {
            errorHandlerView.backgroundColor = UIColor.applicationBarTintColor
            for subView in errorHandlerView.subviews {
                if subView.tag == 1002 {
                    subView.isHidden = false
                    let imageView = subView as? UIImageView
                    imageView?.image = UIImage(named: "iconNoResult")
                }else if subView.tag == 1003 {
                    let messageLabel = subView as? UILabel
                    messageLabel?.text = errorMessage
                }else if subView.tag == 1004 {
                    subView.isHidden = true
                }
            }
        }else if errorType.rawValue == "loading"{
            for subView in errorHandlerView.subviews {
                if subView.tag == 1002 {
                    subView.isHidden = true
                }else if subView.tag == 1003 {
                    let messageLabel = subView as? UILabel
                    messageLabel?.text = errorMessage
                }else if subView.tag == 1004 {
                    subView.isHidden = false
                    let activityIndicator = subView as? UIActivityIndicatorView
                    activityIndicator?.isHidden = false
                    activityIndicator?.startAnimating()
                }
            }
        }else if errorType.rawValue == "business" {
            errorHandlerView.backgroundColor = UIColor.applicationBarTintColor
            for subView in errorHandlerView.subviews {
                if subView.tag == 1002 {
                    subView.isHidden = false
                    let imageView = subView as? UIImageView
                    imageView?.image = UIImage(named: "iconWrong")
                }else if subView.tag == 1003 {
                    let messageLabel = subView as? UILabel
                    messageLabel?.text = errorMessage
                }else if subView.tag == 1004 {
                    subView.isHidden = true
                }
            }
        }
        
        
        self.addSubview(errorHandlerView)
    }
    
    func hideErrorView(view: UIView) {
        self.viewWithTag(1001)?.removeFromSuperview()
    }

    
    // MARK: - Hud Activity
    
    func showActivityLoading() {
        let shadowView = UIView(frame:CGRect(x: 0, y:0, width:self.frame.size.width, height:self.bounds.size.height))
        shadowView.tag = -998;
        shadowView.backgroundColor = UIColor(red: 180.0/255.0, green: 180.0/255.0, blue: 180.0/255.0, alpha: 0.5)
        self.alpha = 0.5
        
        let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        activity.center = self.center
        activity.tag = -999
        
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(shadowView)
        
        self.addSubview(shadowView)
        self.addSubview(activity)
        activity.startAnimating()
    }
    
    func hideActivityLoading() {
        self.alpha = 1.0
        self.viewWithTag(-998)?.removeFromSuperview()
        self.viewWithTag(-999)?.removeFromSuperview()
    }
    
    
    // MARK: - Visual Effects
    func blur(image: UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.frame = self.bounds
        imageView.contentMode = .scaleToFill
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = imageView.bounds
        imageView.addSubview(blurredEffectView)
        
        return imageView
    }
    
    // MARK: - Alert Controller
    func alert(msg: String, sender: UIViewController) {
        let alertController = UIAlertController(title: msg, message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
        }
        alertController.addAction(okAction)
            sender.present(alertController, animated: true) {
        }
    }
    
    
    // MARK: - Command Button
    func showCommandView(commandView: UIView) {
        commandView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 54)
        commandView.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height - 54/2.0)
        commandView.backgroundColor = UIColor.applicationBarTintColor
        commandView.tag = 3000
        self.addSubview(commandView)
        
    }
    func hideCommandView(view: UIView) {
        self.viewWithTag(3000)?.removeFromSuperview()
    }
    
    
    
    
    
}

