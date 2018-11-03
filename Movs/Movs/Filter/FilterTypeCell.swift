//
//  FilterTypeCell.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 02/11/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import UIKit

class FilterTypeCell: UITableViewCell {
  
  var name: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = label.font.withSize(16)
    label.numberOfLines = 0
    label.sizeToFit()
    return label
  }()
  var sample: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = label.font.withSize(16)
    label.textColor = .orange
    label.numberOfLines = 0
    label.sizeToFit()
    return label
  }()
  var nextImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.backgroundColor = .clear
    imageView.contentMode = .scaleAspectFill
    imageView.image = #imageLiteral(resourceName: "next.png")
    return imageView
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    addViews()
  }
  
  func addViews() {
    addSubview(name)
    addSubview(sample)
    addSubview(nextImage)
    
    addConstraints()
  }
  
  func addConstraints() {
    name.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
    name.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
    name.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
    
    nextImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
    nextImage.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
    nextImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
    nextImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
    nextImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
    
    sample.rightAnchor.constraint(equalTo: nextImage.leftAnchor, constant: -5).isActive = true
    sample.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
    sample.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
  }
  
  func configure(name: String, sample: String) {
    self.name.text = name
    self.sample.text = sample
  }
  
}
