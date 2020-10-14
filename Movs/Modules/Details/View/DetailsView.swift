//
//  DetailsView.swift
//  Movs
//
//  Created by Joao Lucas on 13/10/20.
//

import UIKit

protocol DetailsDelegate: class {
    func btnFavorite()
}

class DetailsView: UIView {
    
    weak var delegate: DetailsDelegate!
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
        
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let photo: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 400).isActive = true
        return image
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .systemBlue
        label.numberOfLines = 0
        return label
    }()
    
    let year: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    lazy var favorite: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        button.addTarget(self, action: #selector(buttonFavorite), for: .touchUpInside)
        return button
    }()
    
    let genre: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    let overview: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    private lazy var stackHorizontal: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [year, favorite])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var stackVertical: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [photo, title, stackHorizontal, genre, overview])
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBaseView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonFavorite() {
        delegate.btnFavorite()
    }
}

extension DetailsView: ViewCode {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackVertical)
    }
    
    func setupConstraints() {
        scrollView.layout.applyConstraint { view in
            view.topAnchor(equalTo: topAnchor)
            view.leadingAnchor(equalTo: leadingAnchor)
            view.trailingAnchor(equalTo: trailingAnchor)
            view.bottomAnchor(equalTo: bottomAnchor)
            view.widthAnchor(equalTo: widthAnchor)
        }
        
        contentView.layout.applyConstraint { view in
            view.topAnchor(equalTo: scrollView.topAnchor)
            view.leadingAnchor(equalTo: scrollView.leadingAnchor)
            view.trailingAnchor(equalTo: scrollView.trailingAnchor)
            view.bottomAnchor(equalTo: scrollView.bottomAnchor)
            view.widthAnchor(equalTo: scrollView.widthAnchor)
        }
        
        stackVertical.layout.applyConstraint { view in
            view.topAnchor(equalTo: contentView.topAnchor)
            view.leadingAnchor(equalTo: contentView.leadingAnchor, constant: 16)
            view.trailingAnchor(equalTo: contentView.trailingAnchor, constant: -16)
            view.heightAnchor(equalTo: contentView.heightAnchor)
        }
        
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
