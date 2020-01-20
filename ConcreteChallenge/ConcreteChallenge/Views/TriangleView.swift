//
//  TriangleView.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 18/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit

class TriangleView : UIView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: Images.heartFilled))
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.anchorPoint = CGPoint(x: 1, y: 1)
        
        return imageView
    }()
    
    lazy var blurVisualEffect: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .light)
        let blurVisualEffect = UIVisualEffectView(effect: blur)
        
        blurVisualEffect.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return blurVisualEffect
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubviews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.close()

        blurVisualEffect.frame = path.bounds
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        blurVisualEffect.layer.mask = mask
        self.insertSubview(blurVisualEffect, at: 0)
    }
    
    func addSubviews() {
        addSubview(imageView)
    }
    
    func setupConstraints() {
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
    }
}
