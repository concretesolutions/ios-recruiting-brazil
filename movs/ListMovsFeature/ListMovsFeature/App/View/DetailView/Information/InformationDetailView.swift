//
//  InformationDetailView.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 19/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import AssertModule

class InformationDetailView: UIView {
    
    
    //MARK: Insert Values
    var detailText: String {
        didSet {
            self.detailLabel.text = detailText
        }
    }
    
    var isFavorite: Bool  {
        didSet {
            self.favoriteImageView.image = isFavorite ? Assets.Images.favoriteFullIcon : Assets.Images.favoriteGrayIcon
        }
    }
    
    var isHeader: Bool  {
        didSet {
            self.favoriteImageView.isHidden = !self.isHeader
            self.detailLabel.font = FontAssets.avenirTextCell
        }
    }
    
    init(detailText: String, isHeader: Bool, isFavorite: Bool = false) {
        self.detailText = detailText
        self.isFavorite = isFavorite
        self.isHeader = isHeader
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Creates UI
    private var detailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = FontAssets.avenirTextTitle
        label.textColor = Colors.blueDark
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var favoriteImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private var lineView: UIView = {
        var line = UIView()
        line.backgroundColor = Colors.blueDark
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
}

//MARK: - Lifecycle
extension InformationDetailView {
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setupUI()
        self.fillUpUI()
    }
}

//MARK: - Setup UI
extension InformationDetailView {
    
    private func fillUpUI() {
        self.detailLabel.text = detailText
        
        if self.isHeader {
            self.favoriteImageView.isHidden = false
            self.favoriteImageView.image =
                self.isFavorite ?
                    Assets.Images.favoriteFullIcon :
                    Assets.Images.favoriteGrayIcon
            
            self.detailLabel.font = FontAssets.avenirTextTitle
        
        } else {
            self.favoriteImageView.isHidden = true
            self.detailLabel.font = FontAssets.avenirTextCell
        }        
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        self.addSubview(self.detailLabel)
        self.addSubview(self.favoriteImageView)
        self.addSubview(self.lineView)
        self.setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            favoriteImageView.widthAnchor.constraint(equalToConstant: 20),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 20),
            favoriteImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            favoriteImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            
            detailLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            detailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: favoriteImageView.leadingAnchor, constant: -4),
                        
            lineView.leadingAnchor.constraint(equalTo: detailLabel.leadingAnchor),
            lineView.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 8),
            lineView.trailingAnchor.constraint(equalTo: favoriteImageView.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}
