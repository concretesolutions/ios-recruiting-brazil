//
//  MovieGridErrorView.swift
//  Mov
//
//  Created by Miguel Nery on 28/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

import UIKit

public class MovieGridErrorView: UIView {
    
    // UI Elements
    lazy var errorImage: UIImageView = {
        let errorImage = UIImageView(image: Images.error)
        errorImage.contentMode = .scaleAspectFit
        
        return errorImage
    }()
    
    lazy var errorLabel: UILabel = {
        let errorLabel = UILabel(frame: .zero)
        errorLabel.text = Texts.movieGridError
        errorLabel.textColor = .black
        errorLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(20).proportionalToHeight)
        errorLabel.numberOfLines = 3
        errorLabel.textAlignment = .center
        
        return errorLabel
    }()
    
    
    // Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MovieGridErrorView: ViewCode {
    
    func addView() {
        self.addSubview(self.errorImage)
        self.addSubview(self.errorLabel)
    }
    
    func addConstraints() {
        self.errorImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.8)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        self.errorLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.errorImage.snp_centerXWithinMargins)
            make.top.equalTo(self.errorImage.snp_bottomMargin).multipliedBy(0.85)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
    }
    
    func aditionalSetup() {
        self.backgroundColor = .white
    }
    
    
    
}

