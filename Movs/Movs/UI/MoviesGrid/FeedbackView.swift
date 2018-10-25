//
//  FeedbackView.swift
//  Movs
//
//  Created by Gabriel Reynoso on 24/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class FeedbackView: UIView, ViewCode {
    
    private var imageView:UIImageView! {
        didSet {
            self.imageView.contentMode = .scaleAspectFit
            self.imageView.backgroundColor = .red
            self.addSubview(self.imageView)
        }
    }
    
    private var label:UILabel! {
        didSet {
            self.label.textColor = Colors.darkBlue.color
            self.label.font = Fonts.futuraBold.font(size: 20.0)
            self.label.text = "Testing label in feedback view!"
            self.label.numberOfLines = 0
            self.addSubview(self.label)
        }
    }
    
    var image:UIImage? {
        get {
            return self.imageView.image
        }
        set {
            self.imageView.image = newValue
        }
    }
    
    var text:String? {
        get {
            return self.label.text
        }
        set {
            self.label.text = newValue
        }
    }
    
    func design() {
        self.imageView = UIImageView(image: nil)
        self.label = UILabel(frame: .zero)
    }
    
    func autolayout() {
        // image view
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.label.topAnchor)
        // label
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.label.heightAnchor.constraint(equalToConstant: 50.0)
        self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    }
}
