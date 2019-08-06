//
//  DetailView.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 02/08/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import UIKit

class DetailView: UIView {
    let release:UILabel = {
        let label = UILabel()
        return label
    }()
    let overview:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    let vote:UILabel = {
        let label = UILabel()
        return label
    }()
    let trailerButton:UIButton = {
        let button = UIButton()
        return button
    }()
    let backButton:UIButton = {
        let button = UIButton()
        return button
    }()
    let favoriteButton:UIButton = {
        let button = UIButton()
        return button
    }()
    let background:UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let genrer:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    var image:UIImage?
    
    var detailModel:DetailsViewModel
    
 
     init(movie:Movie) {
        self.detailModel = DetailsViewModel(movie: movie)
        super.init(frame:CGRect.zero)
        initViewCoding()
        updateUI()
        MovieAPI.getYoutubeUrl(id: String(movie.id)){
            result,err  in
            
            if err != nil{
                DispatchQueue.main.async {
                    self.trailerButton.isHidden = true
                }
            }
        }
    
        
    }
    
    //Calls this function when the tap is recognized.
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(){
        self.vote.attributedText = self.detailModel.voteAverage
        self.overview.attributedText = self.detailModel.overview
        self.release.attributedText = self.detailModel.release
        self.genrer.attributedText = self.detailModel.genres
        self.favoriteButton.isSelected = CoreDataAPI.isFavorite(id: String(detailModel.id))
        
    }
    
   
}
extension DetailView:ViewCoding{
    func buildViewHierarchy() {
        self.addSubview(background)
        self.addSubview(release)
        self.addSubview(overview)
        self.addSubview(vote)
        self.addSubview(trailerButton)
        self.addSubview(backButton)
        self.addSubview(genrer)
        self.addSubview(favoriteButton)
        
    }
    func setUpConstraints() {
        background.fillSuperview()
        vote.anchor(top: self.layoutMarginsGuide.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        release.anchor(top: self.layoutMarginsGuide.topAnchor, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        overview.anchor(top: self.vote.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0))
        trailerButton.anchor(top: overview.bottomAnchor, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0),size: CGSize(width: 50, height: 20))
        backButton.anchor(top: nil, leading: nil, bottom: self.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0),size: CGSize(width: 50, height: 20))
        backButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        favoriteButton.anchor(top: nil, leading: nil, bottom: backButton.topAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0),size:CGSize(width: 80, height: 80))
        
 
        favoriteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        genrer.anchor(top: overview.bottomAnchor, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        genrer.centerXAnchor.constraint(equalTo: favoriteButton.centerXAnchor).isActive = true
    }
    func additionalConfigs() {
        background.image = UIImage(named: "old_paper")
        trailerButton.setAttributedTitle(NSAttributedString(string: "Trailer", attributes: Typography.description(Color.scarlet).attributes()), for: .normal)
        backButton.setAttributedTitle(NSAttributedString(string: "Back", attributes: Typography.description(Color.scarlet).attributes()), for: .normal)
        
        favoriteButton.setImage(UIImage(named: "heart_selected")?.withRenderingMode(.alwaysTemplate), for: .selected)
        favoriteButton.setImage(UIImage(named: "heart_unselected")?.withRenderingMode(.alwaysTemplate), for: .normal)
        favoriteButton.tintColor = Color.scarlet

    }
        
}
