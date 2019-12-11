//
//  ExceptionView.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class ExceptionView: UIView {
    // MARK: - Subviews
//    lazy var image: UIImageView = {
//        
//    }()
//    
//    lazy var title: UILabel = {
//        
//    }()
    
    // MARK: - Stacks
    
    // MARK: - Initializers
    required override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExceptionView: CodeView {
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
}
