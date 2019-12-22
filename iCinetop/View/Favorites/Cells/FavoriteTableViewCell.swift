//
//  FavoriteTableViewCell.swift
//  iCinetop
//
//  Created by Alcides Junior on 20/12/19.
//  Copyright © 2019 Alcides Junior. All rights reserved.
//

import UIKit
import SnapKit

class FavoriteTableViewCell: UITableViewCell {
    
    lazy var activityIndicatorToImage:UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    lazy var movieImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    lazy var viewCell: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    lazy var movieTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textColor = UIColor(named: "whiteCustom")
        return view
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.textColor = UIColor(named: "whiteCustom")
        return view
    }()
    
    lazy var overviewTextLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 15)
        view.textColor = UIColor(named: "whiteCustom")
        view.textAlignment = .justified
        return view
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        viewCell.backgroundColor = UIColor(named: "blackCustom")
        movieTitle.numberOfLines = 0
        movieTitle.font = UIFont.boldSystemFont(ofSize: 15)
        overviewTextLabel.numberOfLines = 0
        
        self.addSubview(viewCell)
        self.viewCell.addSubview(movieImageView)
        self.movieImageView.addSubview(activityIndicatorToImage)
        self.viewCell.addSubview(movieTitle)
        self.viewCell.addSubview(releaseDateLabel)
        self.viewCell.addSubview(overviewTextLabel)
        
        
        
        viewCell.snp.makeConstraints { (make) in
            make.top.equalTo(4)
            make.bottom.equalToSuperview().inset(4)
            make.left.equalToSuperview().offset(4)
            make.right.equalToSuperview().inset(4)
        }
        
        activityIndicatorToImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        movieImageView.snp.makeConstraints { (make) in
            make.height.equalTo(viewCell.snp.height)
            make.width.equalTo(movieImageView.snp.height)
            make.top.equalTo(viewCell.snp.top)
            make.left.equalTo(viewCell.snp.left)
            make.bottom.equalTo(viewCell.snp.bottom)
        }
        
        movieTitle.snp.makeConstraints { (make) in
            make.top.equalTo(viewCell.snp.top).offset(4)
            make.left.equalTo(movieImageView.snp.right).offset(4)
            make.right.equalToSuperview().inset(16)
        }
        
        releaseDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(movieTitle.snp.bottom)
            make.left.equalTo(movieImageView.snp.right).offset(4)
            make.right.equalTo(16)
        }
        
        overviewTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(releaseDateLabel.snp.bottom)
            make.left.equalTo(movieImageView.snp.right).offset(4)
            make.right.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().inset(4)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
