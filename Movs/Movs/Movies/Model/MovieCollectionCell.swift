//
//  MovieCollectionCell.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 30/10/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {
  var movie: PopularMovie!
  private var isLiked = false
  private var id = 0
  var originalSizePoster = CGSize()
  private var bottomView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.navy
    
    return view
  }()
  
  var like: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
    return button
  }()
  
  var title: UILabel = {
    let label = UILabel()
    label.font = label.font.withSize(14)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor.yellow
    label.textAlignment = .center
    label.text = "Thor"
    return label
  }()
  
  var posterImage: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.image = UIImage()
    return image
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    self.layer.borderWidth = 0.5
    self.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  
  func configureCell(movie: PopularMovie) {
    self.movie = movie
    like.addTarget(self, action: #selector(likeButtonAction(sender:)), for: .touchUpInside)
    isLiked = DefaultsMovie.shared.contains(id: movie.id)
    title.text = movie.title
    id = movie.id
    Network.shared.requestImage(imageName: movie.poster_path) { (result) in
      switch result {
      case .success(let image):
        self.posterImage.image = image
        self.originalSizePoster = (image?.size)!
      case .failure(let error):
        print("error: \(error.localizedDescription)")
      }
    }
    if isLiked {
      like.setImage(UIImage(named: "favorite_full_icon.png"), for: .normal)
    } else {
      like.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
    }
    
  }
  
  @objc func likeButtonAction(sender: UIButton) {
    isLiked = !DefaultsMovie.shared.contains(id: id)

    if isLiked {
      like.setImage(UIImage(named: "favorite_full_icon.png"), for: .normal)
      DefaultsMovie.shared.saveMoveId(id)
    } else {
      like.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
      DefaultsMovie.shared.deleteId(id)
    }
  }
  
  func addConstrainst() {
    bottomView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    bottomView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    bottomView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    bottomView.heightAnchor.constraint(equalToConstant: 45).isActive = true
    like.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
    like.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -5).isActive = true
    like.heightAnchor.constraint(equalToConstant: 30).isActive = true
    like.widthAnchor.constraint(equalToConstant: 30).isActive = true
    title.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
    title.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 5).isActive = true
    title.rightAnchor.constraint(equalTo: like.leftAnchor, constant: -5).isActive = true
    posterImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    posterImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
    posterImage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    posterImage.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
  }
  
  func setupView() {
    addView()
  }
  
  func addView() {
    addSubview(bottomView)
    addSubview(title)
    bottomView.addSubview(like)
    addSubview(posterImage)
    addConstrainst()
  }
  
  
  
    
}
