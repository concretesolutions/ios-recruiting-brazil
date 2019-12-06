//
//  MovieCellView.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 06/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit
import SnapKit
final class MovieCellView: UICollectionViewCell {
    let imageBackground:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .red
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame:.zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension MovieCellView: CodeView {
    func buildViewHierarchy() {
        self.contentView.addSubview(imageBackground)
    }
    
    func setupConstraints() {
        imageBackground.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
    
    }
    
    
}

