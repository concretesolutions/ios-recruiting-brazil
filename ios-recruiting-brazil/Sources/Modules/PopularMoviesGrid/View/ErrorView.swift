//
//  File.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import UIKit

final class ErrorView: UIView {
    
    private lazy var lbError: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewConfiguration()
        self.backgroundColor = .white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(error: String?) {
        self.lbError.text = error
    }
}

extension ErrorView: ViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(self.lbError)
    }
    
    func setupConstraints() {
        self.lbError.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
