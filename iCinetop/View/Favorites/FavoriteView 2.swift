//
//  Favorite.swift
//  iCinetop
//
//  Created by Alcides Junior on 14/12/19.
//  Copyright © 2019 Alcides Junior. All rights reserved.
//

import UIKit
import SnapKit

final class FavoriteView: UIView {
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        return view
    }()
    
    lazy var noResultsImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    lazy var noResultsLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textColor = UIColor(named: "blackCustom")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func registerCell(){
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension FavoriteView: CodeView{
    func buildViewHierarchy() {
        self.addSubview(self.tableView)
        noResultsImageView.isHidden = true
        noResultsLabel.isHidden = true
        noResultsLabel.numberOfLines = 0
        noResultsLabel.textAlignment = .center
        noResultsImageView.image = UIImage(named: "noresults")
        self.addSubview(noResultsImageView)
        self.addSubview(noResultsLabel)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        noResultsImageView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.2)
            make.width.equalTo(noResultsImageView.snp.height)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        noResultsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(noResultsImageView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            
        }
    }
    
    func setupAdditionalConfiguration() {
        registerCell()
    }
    
    
}
