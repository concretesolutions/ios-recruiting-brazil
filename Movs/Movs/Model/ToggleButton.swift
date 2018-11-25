//
//  ToggleButton.swift
//  Movs
//
//  Created by Julio Brazil on 24/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit

public class ToggleButton: UIButton, CodeView {
    
    var isOn: Bool {
        didSet{
            self.setImage((self.isOn ? self.onImage : self.offImage), for: .normal)
        }
    }
    var onImage: UIImage
    var offImage: UIImage
    
    public var toggleAction: (Bool) -> Void = {_ in }
    
    public init(frame: CGRect = .zero, wiThDefaultValue value: Bool = false, onImage: UIImage, offImage: UIImage) {
        self.isOn = value
        self.onImage = onImage
        self.offImage = offImage
        
        super.init(frame: frame)
        
        self.addTarget(self, action: #selector(self.toggle), for: .primaryActionTriggered)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggle() {
        self.isOn = !self.isOn
        self.toggleAction(self.isOn)
    }
    
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.imageView?.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.imageView?.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.imageView?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        
    }
}
