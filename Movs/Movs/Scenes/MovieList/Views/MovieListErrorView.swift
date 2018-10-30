//
//  MovieListErrorView.swift
//  Movs
//
//  Created by Ricardo Rachaus on 28/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class MovieListErrorView: UIView {
    
    struct ViewError {
        var movieTitle: String?
        var errorType: ErrorType
    }
    
    enum ErrorType: Int {
        case error
        case notFind
    }
    
    lazy var errorImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    lazy var errorLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Um erro ocorreu. Por favor, tente novamente."
        view.numberOfLines = 0
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true
        view.font = UIFont.boldSystemFont(ofSize: 30)
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func error(viewError: ViewError) {
        switch viewError.errorType {
        case .error:
            errorImage.image = UIImage(named: Constants.ImageName.error)
            errorLabel.text = "Um erro ocorreu. Por favor, tente novamente."
        case .notFind:
            errorImage.image = UIImage(named: Constants.ImageName.search)
            errorLabel.text = "Sua busca por \"\(viewError.movieTitle!)\" não resultou em nenhum resultado."
        }
    }
}

extension MovieListErrorView: CodeView {
    func buildViewHierarchy() {
        addSubview(errorImage)
        addSubview(errorLabel)
    }
    
    func setupConstraints() {
        errorImage.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(80)
            make.top.equalToSuperview().inset(200)
        }
        
        errorLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(errorImage.snp.bottom).offset(20)
            make.height.equalTo(70)
        }
    }
    
    func setupAdditionalConfiguration() {
        
    }
}
