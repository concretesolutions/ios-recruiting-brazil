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
        view.image = #imageLiteral(resourceName: "list_icon")
        return view
    }()
    let nameMovie:UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "name movie"
        view.textColor = .yellow
        view.textAlignment = .center
        return view
    }()
    let buttonLike:UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(#imageLiteral(resourceName: "favorite_gray_icon"), for: .normal)
        return view
    }()
    let container:UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 8.0
        stack.backgroundColor = .red
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        container.addArrangedSubview(nameMovie)
        container.addArrangedSubview(buttonLike)
        self.addSubview(container)
    }
    
    func setupConstraints() {
        imageBackground.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(nameMovie.snp.top)
        }
        container.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        buttonLike.snp.makeConstraints { (make) in
            //make.width.height.equalTo(50)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = #colorLiteral(red: 0.1757613122, green: 0.1862640679, blue: 0.2774662971, alpha: 1)
    }
    
    
}

