//
//  ErrorView.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

enum MessageType {
    case errorMessage
    case notFoundMessage
    
    func value() -> (imageName: String, messageTxt: String) {
        switch self {
        case .notFoundMessage:
            return (imageName: "not_found", messageTxt: "Your search hasn't found any result.")
        default:
            return (imageName: "error", messageTxt: "An error has ocurred. Please try again.")
        }
    }
}

struct MessageViewModel {
    let image: UIImage?
    let messageTxt: String
    
    init(withImageNamed imageName: String, andMessage messageTxt: String) {
        self.image = UIImage(named: imageName)
        self.messageTxt = messageTxt
    }
    
    init(with messageType: MessageType) {
        self.image = UIImage(named: messageType.value().imageName)
        self.messageTxt = messageType.value().messageTxt
    }
}

class MessageView: UIView {

    private var imageView = UIImageView()
    private var messageLbl = UILabel()
    
    var viewModel: MessageViewModel? {
        didSet {
            if let viewModel = self.viewModel {
                self.imageView.image = viewModel.image
                self.messageLbl.text = viewModel.messageTxt
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
