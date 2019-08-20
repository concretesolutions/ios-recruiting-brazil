//
//  FilterView.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import UIKit

class FilterView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var picker: UIPickerView = {
        let view = UIPickerView(frame: .zero)
        return view
    }()
    
    let applyButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UsedColor.yellow.color
        return button
    }()
    
}

extension FilterView: CodeView{
    func buildViewHierarchy() {
        addSubview(picker)
        addSubview(applyButton)
    }
    
    func setupConstrains() {
        
        picker.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(175)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        applyButton.snp.makeConstraints { (make) in
            make.left.equalTo(snp_leftMargin)
            make.right.equalTo(snp_rightMargin)
            make.top.equalTo(picker.snp.bottom).offset(50)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
        
    }
}
