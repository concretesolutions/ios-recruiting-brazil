//
//  ToggleButton.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class ToggleButton: UIVisualEffectView, ViewCodable {
    public var firstOptionIsSelected = true {
        didSet {
            wasToggledCompletion?(self.firstOptionIsSelected)
        }
    }
    
    public var wasToggledCompletion: ((Bool) -> Void)?
    
    private let firstOptionImageView = UIImageView().build(block: formatOptionView)
    private let secondOptionImageView = UIImageView().build(block: formatOptionView)
    private let overlayView = UIView().build {
        $0.backgroundColor = .appLightRed
        $0.layer.cornerRadius = 5
    }
    
    private let contentLayoutGuide = UILayoutGuide()
    private var overlayViewLeftConstraint: NSLayoutConstraint?
    
    init(firstImage: UIImage, secondImage: UIImage) {
        super.init(effect: UIBlurEffect(style: .dark))
        firstOptionImageView.image = firstImage
        secondOptionImageView.image = secondImage
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy() {
        self.contentView.addSubViews(overlayView, firstOptionImageView, secondOptionImageView)
        addLayoutGuide(contentLayoutGuide)
    }
    
    func addConstraints() {
        contentLayoutGuide.layout.group
            .width(.margin(-30)).height(.margin(-10))
            .centerX.centerY
            .fill(to: self)
                
        let dimensionAndVerticalConstraintsBlock: (LayoutProxy) -> Void = { [weak self] in
            $0.group.height(.multiply(0.7))
                    .width(.multiply(0.5))
                    .centerY
                    .fill(to: self?.contentLayoutGuide)
        }
        
        firstOptionImageView.layout.build(block: dimensionAndVerticalConstraintsBlock).build {
            $0.left.equal(to: contentLayoutGuide.layout.left)
        }
        
        secondOptionImageView.layout.build(block: dimensionAndVerticalConstraintsBlock).build {
            $0.right.equal(to: contentLayoutGuide.layout.right)
        }
        
        overlayView.layout.group
            .height.width(.multiply(0.5))
            .centerY
            .fill(to: contentLayoutGuide)
        
        self.overlayViewLeftConstraint = overlayView.layout.left.equal(to: contentLayoutGuide.layout.left)
    }
    
    func applyAditionalChanges() {
        self.clipsToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height/2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch = touches.first,
              let touchedView = firstTouch.view else {
            return
        }
        
        switch touchedView {
        case firstOptionImageView:
            firstOptionIsSelected = true
            animateOverlayMovement(toAnchor: contentLayoutGuide.layout.left.layout.left)
        case secondOptionImageView:
            firstOptionIsSelected = false
            animateOverlayMovement(toAnchor: contentLayoutGuide.layout.left.layout.centerX)
        default:
            break
        }
    }
    
    private static func formatOptionView(optionView: UIImageView) {
        optionView.contentMode = .scaleAspectFit
        optionView.isUserInteractionEnabled = true
    }
    
    private func animateOverlayMovement(toAnchor anchor: DefaultLayoutPropertyProxy<NSLayoutXAxisAnchor>) {
        self.overlayView.superview?.layoutIfNeeded()
        self.overlayViewLeftConstraint?.isActive = false
        self.overlayViewLeftConstraint = overlayView.layout.left.equal(to: anchor)
        
        UIView.animate(withDuration: 0.5) {
            self.overlayView.superview?.layoutIfNeeded()
        }
    }
}
