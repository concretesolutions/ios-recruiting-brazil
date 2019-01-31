//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by Brendoon Ryos on 24/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit
import Reusable
import SnapKit

final class MovieCollectionViewCell: UICollectionViewCell, Reusable {
  let gridView = MovieGridView()
  
  static func size(for parentWidth: CGFloat) -> CGSize {
    let numberOfCells: CGFloat = 2
    let spacing = AppearanceProxyHelper.collectionViewSpacing * (numberOfCells + 1)
    let width = (parentWidth - spacing) / numberOfCells
    let height = width * (3/2)
    return CGSize(width: width, height: height)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViewCode()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    gridView.imageView.image = nil
    gridView.titleLabel.text = nil
    gridView.activityIndicator.stopAnimating()
  }
  
  func setup(with item: Movie, hasPoster: Bool = true) {
    if hasPoster {
      gridView.imageView.download(image: item.posterPath, activityIndicator: gridView.activityIndicator)
    } else {
      gridView.imageView.image = UIImage(named: "noImage")
    }
    gridView.titleLabel.text = item.title
  }
}

extension MovieCollectionViewCell: ViewCode {
  func buildViewHierarchy() {
    addSubview(gridView)
  }
  
  func setupConstraints() {
    gridView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.bottom.equalToSuperview()
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
    }
  }
  
  func configureViews() {
    layer.shadowColor = ColorPalette.black.withAlphaComponent(0.6).cgColor
    layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
    layer.shadowOpacity = 0.8
    layer.shadowRadius = 4
    backgroundColor = .gray
  }
}
