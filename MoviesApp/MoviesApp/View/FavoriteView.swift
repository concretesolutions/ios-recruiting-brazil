//
//  FavoriteView.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import UIKit
import SnapKit

//MARK: - The view basic configuration and create the visual elements
class FavoriteView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var search: UISearchBar = {
        let view = UISearchBar()
        return view
    }()
    
    lazy var removeFilterButton: UIButton = {
        let view = UIButton()
        view.setTitle("Remove filters", for: .normal)
        view.setTitleColor(UsedColor.yellow.color, for: .normal)
        view.backgroundColor = UsedColor.blue.color
        return view
    }()
    
    
    lazy var table: UITableView = {
        let view = UITableView()
        view.rowHeight = 120
        view.separatorStyle = .singleLine
        return view
    }()
    
    lazy var resultLabel: UILabel = {
        let view = UILabel()
        view.text = "No result!"
        view.font = UIFont.systemFont(ofSize: 35)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.textColor = .black
        view.isHidden = false
        return view
    }()
}


extension FavoriteView {
    func reloadResults(){
        resultLabel.isHidden = true
        table.isHidden = false
        table.reloadData()
    }
    
    func showFilterError(){
        resultLabel.isHidden = false
        table.isHidden = true
    }
}


//MARK: - Extension to define the view constraints
extension FavoriteView: CodeView{
    func buildViewHierarchy() {
        addSubview(table)
        addSubview(removeFilterButton)
        bringSubviewToFront(removeFilterButton)
        addSubview(resultLabel)
    }
    
    func setupConstrains() {
        table.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(removeFilterButton.snp.bottom)
            make.bottom.equalTo(table.contentSize)
        }
        
        removeFilterButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(snp_topMargin)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        resultLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
        table.backgroundColor = .white
        table.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseIdentifier)
    }
}
