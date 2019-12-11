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
    lazy var image: UIImageView = {
        let view = UIImageView(image: UIImage(named: self.type.rawValue.capitalized))
        return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        view.textAlignment = .center
        view.textColor = .black
        switch self.type {
        case .error:
            view.text = "Um erro ocorreu. Por favor, tente novamente"
        case .emptySearch:
            view.text = "Sua busca não teve nenhum resultado"
        }
        return view
    }()
    
    // MARK: - Attributes
    let type: ExceptionType
    
    // MARK: - Initializers
    required init(frame: CGRect = .zero, type: ExceptionType) {
        self.type = type
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Exception type
    enum ExceptionType: String {
        case error, emptySearch
    }
}

extension ExceptionView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.image)
        self.addSubview(self.title)
    }
    
    func setupConstraints() {
        self.image.snp.makeConstraints { (make) in
            make.height.equalTo(150)
            make.width.equalTo(150)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1)
        }
        
        self.title.snp.makeConstraints { (make) in
            make.width.equalTo(250)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.image.snp.bottom).offset(16)
        }
    }
}
