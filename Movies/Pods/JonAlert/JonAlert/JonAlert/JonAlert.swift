//
//  JonAlert.swift
//  JonAlert
//
//  Created by Jonathan Martins on 02/09/2018.
//  Copyright © 2018 Surrey. All rights reserved.
//

import UIKit
import Foundation

open class JonAlert:UIView{
    
    /// The box that holds the displayed views
    private let wrapper: UIView = {
        let view = UIView()
        view.cornerRadius = 10
        view.backgroundColor = UIColor.init(hexString: "#AA000000")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// The icon of the alert
    private let icon:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /// The label responsable for displaying the message in the alert
    private let message: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.alpha = 0.0
        self.isUserInteractionEnabled = false
        
        setWrapperConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Sets the constraints to the warpper
    private func setWrapperConstraints(){
        self.addSubview(wrapper)
        wrapper.addSubview(message)
        
        NSLayoutConstraint.activate([
            wrapper.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            wrapper.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    /// Sets the contraints to the message label
    private func setMessageConstraints(){
        NSLayoutConstraint.activate([
            wrapper.widthAnchor   .constraint(equalTo: self.widthAnchor, multiplier: 1/2.2),
            message.topAnchor     .constraint(equalTo: wrapper.topAnchor     , constant: 20),
            message.bottomAnchor  .constraint(equalTo: wrapper.bottomAnchor  , constant: -20),
            message.leadingAnchor .constraint(equalTo: wrapper.leadingAnchor , constant: 20),
            message.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -20),
        ])
    }
    
    /// Sets the contraints the message label and teh icon
    private func setFullConstraints(){
        
        wrapper.addSubview(icon)
        NSLayoutConstraint.activate([
            icon.widthAnchor  .constraint(equalToConstant: 35),
            icon.heightAnchor .constraint(equalToConstant: 35),
            icon.topAnchor    .constraint(equalTo: wrapper.topAnchor, constant: 20),
            icon.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor),

            message.topAnchor     .constraint(equalTo: icon.bottomAnchor, constant: 10),
            message.bottomAnchor  .constraint(equalTo: wrapper.bottomAnchor  , constant: -20),
            message.leadingAnchor .constraint(equalTo: wrapper.leadingAnchor , constant: 20),
            message.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -20),
            message.widthAnchor   .constraint(equalTo: self.widthAnchor, multiplier: 1/3),
        ])
    }
    
    /// Displays the alert with the given message and icon
    open static func show(message:String, andIcon icon:UIImage?=nil, duration:TimeInterval=1.0){
        
        /// Gets the instance of the Window
        guard let window = UIApplication.shared.keyWindow else{
            fatalError("No access to UIApplication Window")
        }
        
        /// Creates an instance of our alert
        let alert = JonAlert(frame: CGRect(x: window.frame.origin.x, y: window.frame.origin.y, width: window.frame.width, height: window.frame.height))
        
        /// Checks if it is going to display an icon, if so, sets the constraints to all views, otherwise,
        /// sets the constraints only to the message label
        if let icon = icon{
            alert.icon.image = icon
            alert.setFullConstraints()
        }
        else{
            alert.setMessageConstraints()
        }
        alert.message.text = message
        
        /// Adds the alert to the main Window
        window.addSubview(alert)
        
        /// Animates the alert to show and disappear from the view
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
            alert.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, delay: duration, options: .curveEaseOut, animations: {
                alert.alpha = 0.0
                alert.frame.origin.y = alert.frame.origin.y + 50
            }, completion: { _ in
                alert.removeFromSuperview()
            })
        })
    }
    
    /// Displays the alert with a given message and a success icon
    open static func showSuccess(message:String, duration:TimeInterval=1.0){
        let image = UIImage(named:"icon_success", in: Bundle(for: JonAlert.self), compatibleWith: nil)
        show(message: message, andIcon: image, duration: duration)
    }
    
    /// Displays the alert with a given message and an error icon
    open static func showError(message:String, duration:TimeInterval=1.0){
        let image = UIImage(named:"icon_error", in: Bundle(for: JonAlert.self), compatibleWith: nil)
        show(message: message, andIcon: image, duration: duration)
    }
}

