//
//  FeedbackView.swift
//  Movs
//
//  Created by Gabriel Reynoso on 24/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class FeedbackView: UIView {
    
    private var stackView:UIStackView! {
        didSet {
            self.stackView.axis = .vertical
            self.stackView.alignment = .center
            self.stackView.spacing = 10.0
            self.stackView.distribution = .fill
            self.addSubview(self.stackView)
        }
    }
    
    private var imageView:UIImageView! {
        didSet {
            self.imageView.contentMode = .scaleAspectFill
        }
    }
    
    private var label:UILabel! {
        didSet {
            self.label.textColor = Colors.darkBlue.color
            self.label.font = Fonts.futuraBold.font(size: 20.0)
            self.label.textAlignment = .center
            self.label.numberOfLines = 0
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
}

extension FeedbackView: ViewCode {
    
    func design() {
        self.imageView = UIImageView(image: nil)
        self.label = UILabel(frame: .zero)
        self.stackView = UIStackView(arrangedSubviews: [self.imageView, self.label])
    }
    
    func autolayout() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        self.stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
