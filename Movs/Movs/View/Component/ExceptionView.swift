//
//  ExceptionView.swift
//  Movs
//
//  Created by Lucca França Gomes Ferreira on 20/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit

class ExceptionView: UIView {
    
    enum State {
        case firstLoading
        case loading
        case loaded
        case error
        case noFavorites
        case withoutNetwork
        case search
        case searchNoData
        case none
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    var state: State = .none {
        didSet {
            let imageConfiguration = UIImage.SymbolConfiguration(weight: .thin)
            switch self.state {
            case .withoutNetwork:
                imageView.image = UIImage(systemName: "wifi.slash", withConfiguration: imageConfiguration)
                titleLabel.text = "You are not connected to the internet."
            case .searchNoData:
                imageView.image = UIImage(systemName: "magnifyingglass", withConfiguration: imageConfiguration)
                titleLabel.text = "Your search returned no result"
            case .noFavorites:
                imageView.image = UIImage(systemName: "heart", withConfiguration: imageConfiguration)
                titleLabel.text = "You don't have any favorite movies yet"
            case .firstLoading:
                imageView.image = UIImage(systemName: "film", withConfiguration: imageConfiguration)
                titleLabel.text = "Loading popular movies"
            default: break
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupView()
    }
    
}

extension ExceptionView: ViewCode {
    
    func buildViewHierarchy() {
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
    }
    
    func setupConstraints() {
        self.imageView.snp.makeConstraints { (make) in
            make.height.equalTo(100)
            make.width.equalTo(self.imageView.snp.height).multipliedBy(1.1)
            make.center.equalToSuperview()
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(250)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom).offset(16)
        }
    }
    
    func setupAdditionalConfiguration() {}

}
