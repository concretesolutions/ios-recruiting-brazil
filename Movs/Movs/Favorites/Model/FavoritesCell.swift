//
//  FavoritesCell.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 02/11/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell {
  
  var movie: PopularMovie!
  
  var posterImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  var title: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.sizeToFit()
    return label
  }()
  
  var date: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = label.font.withSize(16)
    label.textAlignment = .right
    return label
  }()
  
  var overview: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = label.font.withSize(14)
    label.numberOfLines = 3
    label.sizeToFit()
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    //selectionStyle = .none
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureCell(movie: PopularMovie) {
    self.movie = movie
    self.title.text = movie.title
    self.date.text = "\(self.getDate(stringDate: (movie.release_date)).year!)"
    self.overview.text = movie.overview.isEmpty ? "sem descrição*" : movie.overview
    Network.shared.requestImage(imageName: movie.poster_path) { (result) in
      switch result {
      case .success(let image):
        self.posterImage.image = image
      case .failure(let error):
        print("error: \(error.localizedDescription)")
      }
    }
    
  }
  
  private func heightForView(label:UILabel) -> CGFloat{
    let auxLabel:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: label.frame.width, height: .greatestFiniteMagnitude))
    auxLabel.numberOfLines = label.numberOfLines
    auxLabel.font = label.font
    auxLabel.text = label.text
    label.sizeToFit()
    return label.frame.height
  }
  
  private func getDate(stringDate: String) -> DateComponents  {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyy-MM-dd"
    dateFormat.locale = Locale(identifier: "pt_BR")
    let date = dateFormat.date(from: stringDate)
    let components = Calendar.current.dateComponents([.year], from: date!)
    return components
  }
  
  func setupView() {
    addViews()
  }
  
  func addViews() {
    addSubview(posterImage)
    addSubview(title)
    addSubview(date)
    addSubview(overview)
    addConstrains()
  }
  
  func addConstrains() {
    posterImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    posterImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
    posterImage.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor).isActive = true
    posterImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
    posterImage.widthAnchor.constraint(equalToConstant: 105).isActive = true
    
    title.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: 15).isActive = true
    title.topAnchor.constraint(equalTo: posterImage.topAnchor, constant: 15).isActive = true
    title.rightAnchor.constraint(equalTo: date.leftAnchor, constant: -5).isActive = true
    
    date.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
    date.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
    date.widthAnchor.constraint(equalToConstant: 40).isActive = true
    
    overview.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: 15).isActive = true
    overview.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10).isActive = true
    overview.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
//    overview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    overview.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -15).isActive = true
  }
  
}
