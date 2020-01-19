//
//  EmptyState.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 19/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit

protocol EmptyStateViewDelegate: class {
    func retryRequest()
}

enum States {
    case requestError
    case emptySearch
    case emptyFavorites
}

class EmptyStateView: UIView {
    
    weak var delegate: EmptyStateViewDelegate?
    
    var state: States {
        didSet {
            setupState()
        }
    }
    
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 15
        
        return stackView
    }()
    
    lazy private var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .lightGray
        
        return imageView
    }()
    
    lazy private var label: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.textColor = .lightGray
        
        return label
    }()
    
    lazy private var button: UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tentar Novamente", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return button
    }()

    init(state: States = .requestError) {
        self.state = state
        super.init(frame: .zero)
        
        addSubviews()
        setupConstraints()
        setupState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupState() {
        DispatchQueue.main.async {
            switch self.state {
            case .requestError:
                self.imageView.image = UIImage(named: Images.error)
                self.label.text = EmptyStateText.requestError
                self.stackView.addArrangedSubview(self.button)
            case .emptySearch:
                self.imageView.image = UIImage(named: Images.search)
                self.label.text = EmptyStateText.emptySearch
                self.button.removeFromSuperview()
            case .emptyFavorites:
                self.imageView.image = UIImage(named: Images.twoHearts)
                self.label.text = EmptyStateText.emptyFavorites
                self.button.removeFromSuperview()
            }
        }
    }
    
    @objc
    func buttonTapped() {
        delegate?.retryRequest()
    }
    
    func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
    }
    
    func setupConstraints() {
        imageView.widthAnchor.constraint(equalToConstant: 42).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
