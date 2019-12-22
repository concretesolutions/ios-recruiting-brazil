//
//  ToggleButton.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

struct ToggleButtonItem {
    var image: UIImage?
}

class ToggleButton: UIVisualEffectView, ViewCodable {
    public var wasToggledCompletion: ((Int) -> Void)?
    private let items: [ToggleButtonItem]
    private var currentItem = 0 {
        didSet {
            self.wasToggledCompletion?(currentItem)
        }
    }
    
    private lazy var itemsViews: [UIImageView] = {
        return self.items.map { (toggleItem) -> UIImageView in
            return UIImageView(image: toggleItem.image).build(block: ToggleButton.formatOptionView)
        }
    }()
    
    private let overlayView = UIView().build {
        $0.backgroundColor = .appLightRed
        $0.layer.cornerRadius = 5
    }
    
    private let contentLayoutGuide = UILayoutGuide()
    private var overlayViewLeftConstraint: NSLayoutConstraint?
    
    init(items: [ToggleButtonItem]) {
        self.items = items
        super.init(effect: UIBlurEffect(style: .dark))
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy() {
        self.contentView.addSubViews(overlayView)
        self.contentView.addSubViews(itemsViews)
        addLayoutGuide(contentLayoutGuide)
    }
    
    func addConstraints() {
        contentLayoutGuide.layout.group
            .width(.margin(-30))
            .height(.margin(-10))
            .centerX.centerY
            .fill(to: self)
                
        let dimensionAndVerticalConstraintsBlock: (LayoutProxy) -> Void = { [weak self] in
            $0.group.height(.multiply(0.7))
                    .centerY
                    .fill(to: self?.contentLayoutGuide)
            $0.width.equal(to: $0.height, multiplier: 2)
        }
        
        var previousItemView: UIView?
        itemsViews.forEach { (itemView) in
            itemView.layout.build(block: dimensionAndVerticalConstraintsBlock)
            
            if let previsousItemView = previousItemView {
                itemView.layout.left.equal(to: previsousItemView.layout.right, offsetBy: 10)
            } else {
                itemView.layout.left.equal(to: contentLayoutGuide.layout.left)
            }
            
            previousItemView = itemView
        }
        
        if let lastItemView = previousItemView {
            lastItemView.layout.right.equal(to: contentLayoutGuide.layout.right)
        }
        
        overlayView.layout.group
            .height
            .width(.multiply(CGFloat(1)/CGFloat(self.items.count)))
            .centerY
            .fill(to: contentLayoutGuide)
        
        self.overlayViewLeftConstraint = self.itemsViews.first?.layout.centerX.equal(to: overlayView.layout.centerX)
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
              let touchedView = firstTouch.view as? UIImageView else {
            return
        }
        
        let itemIndex = itemsViews.firstIndex { (currentItem) -> Bool in
            return currentItem == touchedView
        }
        
        guard let safeItemIndex = itemIndex, currentItem != safeItemIndex else {
            return
        }
        
        currentItem = safeItemIndex
        animateOverlayMovement(toAnchor: touchedView.layout.centerX)
    }
    
    private static func formatOptionView(optionView: UIImageView) {
        optionView.contentMode = .scaleAspectFit
        optionView.isUserInteractionEnabled = true
    }
    
    private func animateOverlayMovement(toAnchor anchor: DefaultLayoutPropertyProxy<NSLayoutXAxisAnchor>) {
        self.overlayView.superview?.layoutIfNeeded()
        self.overlayViewLeftConstraint?.isActive = false
        self.overlayViewLeftConstraint = overlayView.layout.centerX.equal(to: anchor)
        
        UIView.animate(withDuration: 0.5) {
            self.overlayView.superview?.layoutIfNeeded()
        }
    }
}
