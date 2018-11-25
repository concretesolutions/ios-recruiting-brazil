//
//  ButtonsSet.swift
//  DynamicButtonsSet
//
//  Created by Renan Germano on 10/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

// MARK: - Delegate Protocol
protocol ButtonsSetDelegate {
    func didClickButtonWith(title: String)
    func didSelecButtonWith(title: String)
    func didDeselectButtonWith(title: String)
}

class ButtonsSet: UIStackView {
    
    // MARK: - Types definition
    
    enum Order {
        case Original
        case AlphabeticAsc
        case AlphabeticDesc
        case SizeAsc
        case SizeDesc
        case Otimized
    }
    
    enum ButtonBehavior {
        case Click
        case Select
    }
    
    class Style {
        
        init(titleColor: UIColor, titleBold: Bool, backgroundColor: UIColor, borderWidth: Float, borderColor: UIColor, cornerRadius: Float) {
            self.titleColor = titleColor
            self.titleBold = titleBold
            self.backgroundColor = backgroundColor
            self.borderWidth = borderWidth
            self.borderColor = borderColor
            self.cornerRadius = cornerRadius
        }
        
        var titleColor: UIColor
        var titleBold: Bool
        var backgroundColor: UIColor
        var borderWidth: Float
        var borderColor: UIColor
        var cornerRadius: Float
        
    }
    
    // MARK: - Delegate
    
    var delegate: ButtonsSetDelegate?
    
    // MARK: - Properties
    private(set) var width: Float
    private(set) var buttonHeight: Float
    private(set) var buttonNames: [String]
    private(set) var order: Order
    private(set) var buttonNormalStyle: Style?
    private(set) var buttonHighlitedStyle: Style?
    private(set) var buttonBehavior: ButtonBehavior
    private var currentStyles: [String:Style] = [:]
    
    // MARK: - Initializers
    
    init(width: Float, buttonHeight: Float = 60.0, spacing: Float = 7.0, buttonNames: Set<String>, order: Order = .Otimized, buttonNormalStyle: Style, buttonHighlitedStyle: Style, buttonBehavior: ButtonBehavior = .Click) {
        self.width = width
        self.buttonHeight = buttonHeight
        self.buttonNames = Array(buttonNames)
        self.order = order
        self.buttonNormalStyle = buttonNormalStyle
        self.buttonHighlitedStyle = buttonHighlitedStyle
        self.buttonBehavior = buttonBehavior
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: CGFloat(width), height: CGFloat(width))))
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillEqually
        self.spacing = CGFloat(spacing)
        self.isUserInteractionEnabled = true
        self.build(width, buttonHeight, spacing, self.buttonNames, order)
    }
    
    init(width: Float, buttonHeight: Float = 60.0, spacing: Float = 7.0, buttonNames: Set<String>, order: Order = .Otimized, buttonBehavior: ButtonBehavior = .Click) {
        self.width = width
        self.buttonHeight = buttonHeight
        self.buttonNames = Array(buttonNames)
        self.order = order
        self.buttonNormalStyle = nil
        self.buttonHighlitedStyle = nil
        self.buttonBehavior = buttonBehavior
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: CGFloat(width), height: CGFloat(width))))
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillEqually
        self.spacing = CGFloat(spacing)
        self.isUserInteractionEnabled = true
        self.build(width, buttonHeight, spacing, self.buttonNames, order)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Aux functions
    private func build(_ width: Float, _ height: Float, _ spacing: Float, _ names: [String], _ order: Order) {
        
        // Internal aux variables
        
        var namesInFinalOrder: [String] = []
        
        switch order {
            case .Original:
                namesInFinalOrder = names
            case .AlphabeticAsc:
                namesInFinalOrder = names.sorted()
            case .AlphabeticDesc:
                namesInFinalOrder = names.sorted().reversed()
            case .SizeAsc:
                namesInFinalOrder = names.sorted { return $0.count < $1.count }
            case .SizeDesc, .Otimized:
                namesInFinalOrder = names.sorted { return $0.count > $1.count }
        }
        
        print(namesInFinalOrder)
        var buttons: [UIButton] = namesInFinalOrder.map { (name: String) -> UIButton in
            var button = UIButton()
            button.setTitle(name.trimmingCharacters(in: CharacterSet(charactersIn: " ")), for: .normal)
            button.backgroundColor = .lightGray
            button.isUserInteractionEnabled = true
            if let normalStyle = self.buttonNormalStyle { self.add(style: normalStyle, to: button, in: .normal) }
            button.addTarget(self, action: #selector(self.touchDown(button:)), for: .touchDown)
            button.addTarget(self, action: #selector(self.touchUpInside(button:)), for: .touchUpInside)
            button.addTarget(self, action: #selector(self.touchUpOutside(button:)), for: .touchUpOutside)
            return button
        }
        var horizontalStacks: [UIStackView] = []
        var currentHorizontalStack: UIStackView!
        
        // Internal aux functions
        
        // Create a new horizontal stack, add it to the stacks list and sets as the current stack.
        func createHorizontalStackWith(button: UIButton) {
            currentHorizontalStack = UIStackView(arrangedSubviews: [button])
            currentHorizontalStack.frame.size = CGSize(width: CGFloat(width), height: CGFloat(height))
            currentHorizontalStack.axis = .horizontal
            currentHorizontalStack.alignment = .fill
            currentHorizontalStack.distribution = .fillProportionally
            currentHorizontalStack.spacing = CGFloat(spacing)
            currentHorizontalStack.isUserInteractionEnabled = true
            horizontalStacks.append(currentHorizontalStack)
        }
        
        // Try to add a new button to the current stack. Returns a boolean if succed or not.
        func tryToAdd(button: UIButton) -> Bool {
            currentHorizontalStack.addArrangedSubview(button)
            if !isEveryButtonLegibleOn(stack: currentHorizontalStack) {
                currentHorizontalStack.removeArrangedSubview(button)
                return false
            }
            return true
        }
        
        // Checks if every button title is readable or not
        func isEveryButtonLegibleOn(stack: UIStackView) -> Bool {
            var totalOfStackWidthUsed: Float = Float(stack.arrangedSubviews.count - 1) * spacing
            for view in stack.arrangedSubviews {
                guard let button = view as? UIButton else {
                    fatalError("All StackView elements should be of type UIButton.")
                }
                totalOfStackWidthUsed += Float(button.intrinsicContentSize.width) + Float(button.layer.borderWidth * 2)
            }
            return totalOfStackWidthUsed <= width
        }
        
        // Creating the first horizontal stack with the first button
        createHorizontalStackWith(button: buttons.removeFirst())
        
        if order != .Otimized {
            for button in buttons {
                if !tryToAdd(button: button) {
                    createHorizontalStackWith(button: button)
                }
            }
        } else {
            for _ in Range(uncheckedBounds: (0, buttons.count)) {
                
                // Unwraping first and last buttons
                if let first = buttons.first, let last = buttons.last {
                    
                    // Trying to add first button
                    if tryToAdd(button: first) {
                        _ = buttons.removeFirst() // If successful removes it
                    } else { // Else, try to add the last
                        if tryToAdd(button: last) {
                            _ = buttons.popLast() // If successful removes the last
                        } else { // Else, creates a new stack with the first button and removes it
                            createHorizontalStackWith(button: first)
                            buttons.removeFirst()
                        }
                    }
                }
            }
        }
        
        horizontalStacks.forEach {
            self.addArrangedSubview($0)
            $0.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
            $0.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        }
        
        self.frame.size.height = CGFloat(( Float(horizontalStacks.count) * height ) + ( ( Float(buttons.count) - 1 ) * spacing ))
        
    }
    
    private func add(style: Style, to button: UIButton, in state: UIButton.State) {
        self.currentStyles[button.titleLabel?.text ?? ""] = style
        button.backgroundColor = style.backgroundColor
        if style.titleBold {
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: button.titleLabel?.font.pointSize ?? 0)
        }
        button.layer.borderColor = style.borderColor.cgColor
        button.layer.borderWidth = CGFloat(style.borderWidth)
        button.setTitleColor(style.titleColor, for: state)
        button.layer.cornerRadius = CGFloat(style.cornerRadius)
    }
    
    // MARK: - Actions
    
    @objc private func touchDown(button: UIButton) {
        self.delegate?.didClickButtonWith(title: button.titleLabel?.text ?? "")
        if self.buttonBehavior == .Click {
            if let highlitedStyle = self.buttonHighlitedStyle {
                self.add(style: highlitedStyle, to: button, in: .highlighted)
            }
        } else {
            if let bns = self.buttonNormalStyle,
               let bhs = self.buttonHighlitedStyle,
               let title = button.titleLabel?.text,
               let currentStyle = self.currentStyles[title] {
                if currentStyle === bns {
                    self.add(style: bhs, to: button, in: .normal)
                    self.add(style: bhs, to: button, in: .highlighted)
                    self.currentStyles[title] = bhs
                    self.delegate?.didSelecButtonWith(title: title)
                } else {
                    self.add(style: bns, to: button, in: .normal)
                    self.add(style: bns, to: button, in: .highlighted)
                    self.currentStyles[title] = bns
                }
            }
        }
    }
    
    @objc private func touchUpInside(button: UIButton) {
        if let normalStyle = self.buttonNormalStyle, self.buttonBehavior == .Click {
            self.add(style: normalStyle, to: button, in: .normal)
        } else if self.buttonBehavior == .Select, let title = button.titleLabel?.text, self.currentStyles[title] === self.buttonNormalStyle {
            self.delegate?.didDeselectButtonWith(title: title)
        }
    }
    
    @objc private func touchUpOutside(button: UIButton) {
        if let normalStyle = self.buttonNormalStyle, self.buttonBehavior == .Click {
            self.add(style: normalStyle, to: button, in: .normal)
        } else if self.buttonBehavior == .Select, let title = button.titleLabel?.text, self.currentStyles[title] === self.buttonNormalStyle {
            self.delegate?.didDeselectButtonWith(title: title)
        }
    }

}
