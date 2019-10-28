//
//  ErrorView.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class MessageView: UIView {

    private var imageView = UIImageView()
    private var messageLbl = UILabel()
    private weak var parent: UIView?
    
    var viewModel: MessageViewModel? {
        didSet {
            if let viewModel = self.viewModel {
                self.imageView.image = viewModel.image
                self.messageLbl.text = viewModel.messageTxt
                self.toggle(show: true)
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [self.imageView, self.messageLbl])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.backgroundColor = .green
        
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.imageView.heightAnchor.constraint(equalToConstant: 140),
            self.imageView.widthAnchor.constraint(equalToConstant: 140)
        ])
        
        self.backgroundColor = .systemBackground
        
        self.alpha = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addAsSubview(to parent: UIView, withConstraints: Bool = true) {
        // Method created to clean code in VCs that uses this view (same constraints)
        // Check if its the best approach
        self.parent = parent
        parent.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parent.topAnchor),
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: parent.trailingAnchor)
        ])
    }
    
    func toggle(show: Bool) {
        self.parent?.bringSubviewToFront(self)
        UIView.animate(withDuration: 0.5) {
            self.alpha = show ? 1 : 0
        }
    }
    
}
