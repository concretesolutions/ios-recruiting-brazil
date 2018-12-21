//
//  ErrorView.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 20/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import SnapKit

class ErrorView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //FIXME:- create UIImage()
    
    lazy var label:UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}

extension ErrorView: CodeView{
    func buildViewHierarchy() {
        self.addSubview(label)
    }
    
    func setupConstraints() {
        
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
        label.contentMode = .scaleAspectFit
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25.0)
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "Um erro ocorreu. Por favor, tente novamente."
    }
    
    
}
