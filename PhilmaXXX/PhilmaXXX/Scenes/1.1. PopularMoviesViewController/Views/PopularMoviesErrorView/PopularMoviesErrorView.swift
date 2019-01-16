//
//  PopularMoviesErrorView.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 23/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import UIKit

class PopularMoviesErrorView: UIView {
	
	lazy var warningLabel: DetailWhiteLabel = {
		let label = DetailWhiteLabel(frame: .zero)
		label.numberOfLines = 0
		label.font = label.font.withSize(28)
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		
		return label
	}()
	
	lazy var imageView: UIImageView = {
		let imageView = UIImageView(frame: .zero)
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		return imageView
	}()
	
	func setup(viewModel: PopularMoviesErrorViewModel) {
		warningLabel.text = viewModel.message
		imageView.image = viewModel.image
		
		setupView()
	}
	
}

extension PopularMoviesErrorView: CodeView {
	
	func buildViewHierarchy() {
		addSubview(warningLabel)
		addSubview(imageView)
	}
	
	func setupConstraints() {
		let baseInset = ScreenSize.width()/4
		
		imageView.sizeToFit()
		imageView.widthAnchor.constraint(equalToConstant: baseInset).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: baseInset).isActive = true
		imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -baseInset).isActive = true
		
		warningLabel.sizeToFit()
		warningLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
		warningLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
		warningLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
		warningLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
	}
	
	func setupAdditionalConfiguration() {
		
	}
	
	
}
