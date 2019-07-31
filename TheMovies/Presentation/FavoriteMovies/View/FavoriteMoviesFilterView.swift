//
//  FavoriteMoviesFilterView.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/29/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import UIKit

final class FavoriteMoviesFilterView: UIView {
    
    private(set) var datePicker: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private(set) var genrePicker: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private(set) var dateTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Date"
        return view
    }()
    
    private(set) var genreTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Genre"
        return view
    }()
    
    private(set) var label: UILabel = {
        let view = UILabel()
        view.text = "Fields:"
        return view
    }()
    
    private(set) var submitButton: UIButton = {
        let view = UIButton(type: .roundedRect)
        view.backgroundColor = .purple
        view.layer.cornerRadius = 10
        
        view.setTitle("Submit", for: .normal)
        view.setTitleColor(.white, for: .normal)
        return view
    }()
    
    private(set) var cancelButton: UIButton = {
        let view = UIButton(type: .roundedRect)
        view.backgroundColor = .purple
        view.layer.cornerRadius = 10
        
        view.setTitleColor(.white, for: .normal)
        view.setTitle("Cancel", for: .normal)
        return view
    }()
    
    //MARK:- Constructors -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:- Override Methods -
    override func didMoveToWindow() {
        super.didMoveToWindow()
        setupConstraints()
    }
    
    //MARK:- Methods -
    
    fileprivate func setupUIElements() {
        backgroundColor = .white
        
        dateTextField.inputView = datePicker
        genreTextField.inputView = genrePicker
        self.addSubview(dateTextField)
        self.addSubview(genreTextField)
        self.addSubview(submitButton)
        self.addSubview(cancelButton)
        self.addSubview(label)
    }
    
    fileprivate func setupConstraints() {
        let guide = self.safeAreaLayoutGuide
        
        label.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.left.equalTo(guide).inset(20)
            ConstraintMaker.width.height.equalTo(guide.snp.width).multipliedBy(0.2)
        }
        
        dateTextField.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.left.equalTo(label)
            ConstraintMaker.width.equalTo(guide)
            ConstraintMaker.height.equalTo(label)
            ConstraintMaker.top.equalTo(label.snp.bottom)
        }
        
        genreTextField.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalTo(dateTextField)
            ConstraintMaker.left.equalTo(dateTextField)
            ConstraintMaker.height.equalTo(dateTextField)
            ConstraintMaker.width.equalTo(guide)
            ConstraintMaker.top.equalTo(dateTextField.snp.bottom).offset(10)
        }
        
        cancelButton.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.width.centerX.equalTo(label)
            ConstraintMaker.height.equalTo(label).multipliedBy(0.5)
            ConstraintMaker.top.equalTo(genreTextField.snp.bottom).offset(10)
            ConstraintMaker.left.equalTo(label)
        }
        
        submitButton.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.left.equalTo(cancelButton.snp.right).offset(10)
            ConstraintMaker.width.equalTo(label)
            ConstraintMaker.height.equalTo(label).multipliedBy(0.5)
            ConstraintMaker.top.equalTo(genreTextField.snp.bottom).offset(10)
        }
    }
}
