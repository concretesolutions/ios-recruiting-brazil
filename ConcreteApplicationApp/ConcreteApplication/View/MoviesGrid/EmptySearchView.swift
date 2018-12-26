//
//  EmptySearchView.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 26/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//


import UIKit
import SnapKit

protocol EmptySearchDelegate: class {
    func searched(for text: String)
}

class EmptySearchView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var label:UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var text: String = "" {
        didSet{
            DispatchQueue.main.async {
                self.label.text = self.text
            }
        }
    }

}

extension EmptySearchView: CodeView{
    func buildViewHierarchy() {
        self.addSubview(label)
        self.addSubview(imageView)
    }
    
    func setupConstraints() {
        
        label.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalTo(imageView.snp.centerX)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.9)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(imageView.snp.width)
        }
        
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
        
        label.contentMode = .scaleAspectFit
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25.0)
        label.numberOfLines = 0
        label.textColor = .black
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "search_icon")
    }
}
