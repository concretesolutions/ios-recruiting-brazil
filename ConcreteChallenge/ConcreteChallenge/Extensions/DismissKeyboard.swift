//
//  DismissKeyboard.swift
//  KeyboardHandler
//
//  Created by Jonas de Castro Leitao on 21/06/18.
//  Copyright © 2018 Jonas de Castro Leitao. All rights reserved.
//

import UIKit

extension UIViewController : UIGestureRecognizerDelegate {
    
    static var keyboardIsShowing = false
    
    open func enableDismissKeyboard() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.delegate = self
        
        self.observeKeyboard()
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc open func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    open func observeKeyboard(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboard(notification : NSNotification) {
        
        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            UIViewController.keyboardIsShowing = true
            keyboardWillShow(frame: frame, duration: duration)
        } else {
            UIViewController.keyboardIsShowing = false
            keyboardWillHide(frame: frame, duration: duration)
        }
    }
    
    @objc func keyboardWillShow(frame: CGRect, duration: Double) {}
    @objc func keyboardWillHide(frame: CGRect, duration: Double) {}
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if touch.view?.isDescendant(of: self.view) == true && !UIViewController.keyboardIsShowing {
            return false
        }
        
        return true
    }
}
