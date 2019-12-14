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
    var movie:Movie?{
        didSet{
            self.updateUI()
        }
    }
    lazy var imageBackground:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .red
        view.contentMode = .scaleToFill
        view.image = #imageLiteral(resourceName: "list_icon")
        return view
    }()
    lazy var nameMovie:UILabel = {
        let view = UILabel(frame: .zero)
        view.text = nil
        view.textColor = .yellow
        view.textAlignment = .center
        return view
    }()
    lazy var buttonLike:UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        if let movie = self.movie{
            if movieIsfavorite(by: movie.id){
                view.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal)
            }

        }
        return view
    }()
    let container:UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
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
    func updateUI() {
        self.nameMovie.text = self.movie?.title
        if let dest = self.movie?.backdropPath{
            self.imageBackground.loadImageMovie(dest, width: 500)
        }
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
        buttonLike.imageView?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(20)
        })
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = #colorLiteral(red: 0.1757613122, green: 0.1862640679, blue: 0.2774662971, alpha: 1)
    }
    
    
}

