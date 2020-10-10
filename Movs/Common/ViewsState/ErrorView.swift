//
//  ErrorView.swift
//  Movs
//
//  Created by Joao Lucas on 09/10/20.
//

import UIKit

class ErrorView: UIView {
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        view.backgroundColor = .white
        return view
    }()
    
    private var logoError: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "error")
        return image
    }()
    
    private var titleError: UILabel = {
        let label = UILabel()
        label.text = "Erro de conexão"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBaseView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ErrorView: ViewCode {
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(logoError)
        containerView.addSubview(titleError)
    }
    
    func setupConstraints() {
        containerView.layout.applyConstraint { view in
            view.topAnchor(equalTo: topAnchor, constant: 0)
            view.leadingAnchor(equalTo: leadingAnchor, constant: 0)
            view.trailingAnchor(equalTo: trailingAnchor, constant: 0)
            view.bottomAnchor(equalTo: bottomAnchor, constant: 0)
        }
        
        logoError.layout.applyConstraint { view in
            view.centerXAnchor(equalTo: centerXAnchor)
            view.centerYAnchor(equalTo: centerYAnchor)
            view.widthAnchor(equalTo: 100)
            view.heightAnchor(equalTo: 100)
        }
        
        titleError.layout.applyConstraint { view in
            view.topAnchor(equalTo: logoError.bottomAnchor, constant: 20)
            view.centerXAnchor(equalTo: centerXAnchor)
        }
    }
}
