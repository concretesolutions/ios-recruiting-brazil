//
//  FavoriteMoviesScreen.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 10/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit

protocol FilterResetter:class{
    func resetFilter()
}

final class FavoriteMoviesScreen: UIView {
    
    var delegate:FilterResetter?

    lazy var tableView:MoviesTableView = {
        let view = MoviesTableView(tableStyle: .favoriteMovies)
        view.filterResetterDelegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emptyLabel:UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(with state: PresentationState){
        switch state {
        case .ready:
            emptyLabel.isHidden = true
        case .noResults( _):
            emptyLabel.isHidden = false
        default:
            return
        }
    }
    
}

extension FavoriteMoviesScreen: ViewCode{
    func setupViewHierarchy() {
        addSubview(tableView)
        addSubview(emptyLabel)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
    }
    
    func setupAdditionalConfiguration() {
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        
        emptyLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 20.0)
        emptyLabel.textColor = Palette.white
        emptyLabel.text = "No Favorites were found"
        emptyLabel.textAlignment = .center
    }
}

extension FavoriteMoviesScreen: FilterResetter{
    
    func resetFilter() {
        delegate?.resetFilter()
    }
    
}
