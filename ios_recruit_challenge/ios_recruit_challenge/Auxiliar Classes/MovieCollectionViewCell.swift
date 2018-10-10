//
//  MovieCollectionViewCell.swift
//  ios_recruit_challenge
//
//  Created by Lucas de Brito on 09/10/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var isItOneOfTheFavorites:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: CachedImageView = {
        let iv = CachedImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let movieNameCanvas: UIVisualEffectView = {
        let blur = UIBlurEffect(style: UIBlurEffectStyle.light)
        let view = UIVisualEffectView(effect: blur)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let movieNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let favButton: UIButton = {
        let btn = UIButton()
        //btn.setImage(setBtnImage(), for: .normal)
        btn.isUserInteractionEnabled = true
        btn.isEnabled = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    func setupViews(){
        addSubview(imageView)
        imageView.addSubview(movieNameCanvas)
        movieNameCanvas.contentView.addSubview(movieNameLabel)
        movieNameCanvas.contentView.addSubview(favButton)
        addConstraintsWithVisualFormat(format: "V:|[v0]|", views: imageView)
        addConstraintsWithVisualFormat(format: "H:|[v0]|", views: imageView)
        imageView.addConstraintsWithVisualFormat(format: "V:|-140-[v0]|", views: movieNameCanvas)
        imageView.addConstraintsWithVisualFormat(format: "H:|[v0]|", views: movieNameCanvas)
        movieNameCanvas.contentView.addConstraintsWithVisualFormat(format: "V:|[v0]|", views: movieNameLabel)
        movieNameCanvas.contentView.addConstraintsWithVisualFormat(format: "H:|-[v0]-[v1]-|", views: movieNameLabel, favButton)
        movieNameCanvas.contentView.addConstraintsWithVisualFormat(format: "V:|[v0]|", views: favButton)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var view = favButton.hitTest(favButton.convert(point, from: self), with: event)
        if view == nil {
            view = super.hitTest(point, with: event)
        }
        
        return view
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if super.point(inside: point, with: event) {
            return true
        }
        
        return !favButton.isHidden && favButton.point(inside: favButton.convert(point, from: self), with: event)
    }
    
    func setBtnImage() -> UIImage{
        if isItOneOfTheFavorites{
            return UIImage(named: "heart")!
        }else{
            return UIImage(named: "fullHeart")!
        }
    }
    
}
