//
//  ErrorRequestView.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 15/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class ErrorRequestView: UIView {
    lazy var imageView = UIImageView(image: UIImage(named: "error_icon"))
    lazy var label = UILabel()
    lazy var tryAgainButton = UIButton()
    var tryAgainAction: (() -> Void)?
    
    override func didMoveToSuperview() {
        setupView()
    }
}

extension ErrorRequestView: ViewCode {
    func buildViewHierarchy() {
        addSubviews([imageView, label])
    }
    
    func buildConstraints() {
        imageView.anchor
            .top(safeAreaLayoutGuide.topAnchor, padding: 32)
            .centerX(centerXAnchor)
            .width(constant: 200)
            .height(constant: 200)
        
        label.anchor
            .top(imageView.bottomAnchor, padding: 16)
            .centerX(centerXAnchor)
        
        
    }

    func setupTryAgainButton() {
        addSubview(tryAgainButton)
        tryAgainButton.anchor
        .top(label.bottomAnchor, padding: 16)
        .centerX(centerXAnchor)
    }
    func setupAditionalConfiguration() {
        backgroundColor = .white
        label.numberOfLines = 0
        //label.text = "Um erro ocorreu."
        tryAgainButton.setTitleColor(.blue, for: .normal)
        tryAgainButton.setTitle("Tentar novamente", for: .normal)
        tryAgainButton.addTarget(self, action: #selector(tryAgainTapped), for: .touchUpInside)
    }
    
    @objc func tryAgainTapped() {
        tryAgainAction?()
        removeFromSuperview()
    }
}
