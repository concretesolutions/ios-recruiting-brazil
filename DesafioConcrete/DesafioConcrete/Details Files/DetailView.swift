//
//  DetailView.swift
//  DesafioConcrete
//
//  Created by Luiz Otavio Processo on 30/11/19.
//  Copyright © 2019 Luiz Otavio Processo. All rights reserved.
//

import Foundation
import UIKit


class DetailView:UIView{
    
    var poster:UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .clear
        img.contentMode = .scaleToFill
        img.layer.masksToBounds = true
        return img
    }()
    var movieName:UILabel = {
        let lbl = UILabel()
        lbl.isUserInteractionEnabled = true
        lbl.textAlignment = .left
        lbl.textColor = .black
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byCharWrapping
        return lbl
    }()
    var movieYear:UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = .black
        return lbl
    }()
    var movieCategory:UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = .black
        return lbl
    }()
    var movieDescription:UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.numberOfLines = 5
        lbl.lineBreakMode = .byWordWrapping
        lbl.textColor = .black
        return lbl
    }()
    var favButton:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named:"favorite_gray_icon"), for: .normal)
        btn.contentMode = .scaleAspectFill
        return btn
    }()
    
    var isFavorite = false
    var dataStorage = DataStorage()
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        
        let viewWidth = self.frame.width
        let viewHeigth = self.frame.height
        
        self.backgroundColor = .white
        
        self.addSubview(poster)
        self.addSubview(movieName)
        self.addSubview(movieYear)
        self.addSubview(movieCategory)
        self.addSubview(movieDescription)
        movieName.addSubview(favButton)
        
        self.setUpContraint(pattern: "H:|[v0(\(viewWidth))]|", views: poster)
        self.setUpContraint(pattern: "H:|-5-[v0(\(viewWidth))]|", views: movieName)
        self.setUpContraint(pattern: "H:|-5-[v0(\(viewWidth))]|", views: movieYear)
        self.setUpContraint(pattern: "H:|-5-[v0(\(viewWidth))]|", views: movieCategory)
        self.setUpContraint(pattern: "H:|-5-[v0(\(viewWidth/1.01))]|", views: movieDescription)
        
        self.setUpContraint(pattern: "V:|-50-[v0(\(viewHeigth/2.5))][v1(\(viewHeigth/15))][v2(\(viewHeigth/15))][v3(\(viewHeigth/15))][v4(\(viewHeigth/6))]", views: poster,movieName,movieYear,movieCategory,movieDescription)
        
        movieName.setUpContraint(pattern: "H:[v0(\(50))]-10-|", views: favButton)
        movieName.setUpContraint(pattern: "V:[v0(\(viewHeigth/15))]", views: favButton)
        
        addBottomBorder(lbl: movieYear)
        addBottomBorder(lbl: movieCategory)
        addBottomBorder(lbl: movieDescription)
        
        favButton.addTarget(self, action: #selector(makeFavorite), for: .touchUpInside)
    }
    
    func addBottomBorder(lbl:UILabel){
        let bottomBorder = CALayer()
        bottomBorder.backgroundColor = UIColor.black.cgColor
        bottomBorder.frame = CGRect(x: lbl.center.x, y: lbl.frame.height, width: self.frame.width+100, height: 0.5)
        lbl.layer.addSublayer(bottomBorder)
    }
    
    @objc func makeFavorite(){
        
        if(isFavorite){
            favButton.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
            isFavorite = false
        }else if (!isFavorite){
            favButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
            isFavorite = true
            let imageData = poster.image?.pngData()
            let fav = FavModel(movieName: movieName.text!, movieYear: movieYear.text!, movieDescription: movieDescription.text!, moviePoster: imageData!)
            dataStorage.createData(fav: fav)
        }
        
    }
    
    
    
}
