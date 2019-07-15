//
//  FavoritesTableViewCell.swift
//  Movie
//
//  Created by Elton Santana on 15/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    var backdropImageView: UIImageView = UIImageView()
    var titleLabel: UILabel = UILabel()
    var descriptionLabel: UILabel = UILabel()
    var yearLabel: UILabel = UILabel()

    var viewModel: FavoriteTableViewCellViewModel? {
        didSet {
            guard let viewModel = self.viewModel else {
                return
            }
            viewModel.delegate = self
            viewModel.setupComponents()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupVisualComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func setupVisualComponents() {
        [
            self.backdropImageView,
            self.titleLabel,
            self.descriptionLabel,
            self.yearLabel
        ].forEach(self.contentView.addSubview)
        
        self.contentView.backgroundColor = ApplicationColors.gray.uiColor
        
        self.backdropImageView.contentMode = .scaleAspectFit
        self.backdropImageView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(self.contentView).inset(5)
            make.height.equalTo(self.backdropImageView.snp.width).multipliedBy(1)
            
        }
        
        self.titleLabel.textAlignment = .left
        self.titleLabel.numberOfLines = 2
        self.titleLabel.font = .systemFont(ofSize: 12, weight: .bold)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.backdropImageView.snp.top).offset(15)
            make.left.equalTo(self.backdropImageView.snp.right).offset(15)
        }
        
        self.descriptionLabel.textAlignment = .left
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.font = .systemFont(ofSize: 12, weight: .light)
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.bottom.right.equalTo(self.contentView).inset(10)
        }
        
        self.yearLabel.textAlignment = .right
        self.yearLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.titleLabel)
            make.left.equalTo(self.titleLabel.snp.right)
            make.right.equalTo(self.descriptionLabel)
            make.width.equalTo(60)
        }
        
        
        
        
    }

}

extension FavoritesTableViewCell: FavoriteTableViewCellDelegate {
    func setupCell() {
        if let viewModel = self.viewModel {
            DispatchQueue.main.async {
                self.backdropImageView.image = viewModel.image
                self.titleLabel.text = viewModel.name
                self.descriptionLabel.text = viewModel.description
                self.yearLabel.text = viewModel.year
            }
            
        }
    }
}
