//
//  MovieDetailView.swift
//  ios_recruit_challenge
//
//  Created by Lucas de Brito on 10/10/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit

class MovieDetailView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let moviePosterView: CachedImageView = {
        let mp = CachedImageView()
        mp.translatesAutoresizingMaskIntoConstraints = false
        return mp
    }()
    
    let movieInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let movieNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let decorationLine: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let movieDetailLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 100
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func setupView(){
        addSubview(moviePosterView)
        addSubview(movieInfoView)
        addConstraintsWithVisualFormat(format: "H:|[v0]|", views: moviePosterView)
        addConstraintsWithVisualFormat(format: "H:|-[v0]-|", views: movieInfoView)
        addConstraintsWithVisualFormat(format: "V:|[v0(250)]-8-[v1]|", views: moviePosterView,movieInfoView)
        movieInfoView.addSubview(movieNameLabel)
        movieInfoView.addSubview(decorationLine)
        movieInfoView.addSubview(movieDetailLabel)
        movieInfoView.addConstraintsWithVisualFormat(format:  "H:|-[v0]-|", views: movieNameLabel)
        movieInfoView.addConstraintsWithVisualFormat(format:  "H:|-[v0]-|", views: decorationLine)
        movieInfoView.addConstraintsWithVisualFormat(format:  "H:|-[v0]-|", views: movieDetailLabel)
        movieInfoView.addConstraintsWithVisualFormat(format: "V:|-[v0][v1(2)]-[v2]", views: movieNameLabel,decorationLine,movieDetailLabel)
    }
    
}
