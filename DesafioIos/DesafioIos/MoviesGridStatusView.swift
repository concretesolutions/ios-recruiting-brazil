//
//  MoviesGridStatusView.swift
//  DesafioIos
//
//  Created by Kacio on 15/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit

class MoviesGridStatusView: UIView {
    let image:UIImage
    let descriptionScreen:String?
    lazy var imageDescriptionProblem:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.adjustsImageSizeForAccessibilityContentSizeCategory = true
        view.image = self.image
        return view
    }()
    lazy var textDescriptionProblem:UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont(name: "Times New Roman", size: 32)
        view.text = self.descriptionScreen
        view.numberOfLines = 10
        view.textAlignment = .center
        return view
    }()
    init(image:UIImage,description:String?){
        self.image = image
        self.descriptionScreen = description
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension MoviesGridStatusView:CodeView{
    func buildViewHierarchy() {
        self.addSubview(imageDescriptionProblem)
        self.addSubview(textDescriptionProblem)
    }
    
    func setupConstraints() {
        imageDescriptionProblem.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        textDescriptionProblem.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageDescriptionProblem.snp.bottom).offset(15)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
    }
    
    
}
