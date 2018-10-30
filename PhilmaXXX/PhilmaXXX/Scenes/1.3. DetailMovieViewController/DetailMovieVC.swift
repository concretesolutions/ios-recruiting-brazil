//
//  DetailMovieViewController.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 23/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import UIKit
import Domain

final class DetailMovieVC: UIViewController {

	let navigator: ListDetailNavigator
	let viewModel: DetailMovieVCModel
	
	lazy var backgroundImage: UIImageView = {
		let imageView = UIImageView(frame: .zero)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleToFill
		imageView.alpha = 0.3
		imageView.backgroundColor = .black
		return imageView
	}()
	
	lazy var titleLabel: DetailWhiteLabel = {
		let label = DetailWhiteLabel(frame: .zero)
		label.font = label.font.withSize(32)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var yearLabel: DetailWhiteLabel = {
		let label = DetailWhiteLabel(frame: .zero)
		label.font = label.font.withSize(24)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var genresLabel: DetailWhiteLabel = {
		let label = DetailWhiteLabel(frame: .zero)
		label.font = label.font.withSize(24)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var overviewLabel: DetailWhiteLabel = {
		let label = DetailWhiteLabel(frame: .zero)
		label.font = label.font.withSize(18)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var favoriteButton: UIButton = {
		let button = UIButton(frame: .zero)
		button.titleLabel?.text = ""
		button.setImage(#imageLiteral(resourceName: "favorite_empty_icon"), for: .normal)
		button.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.3)
		button.addTarget(self, action: #selector(favoriteButtonPressed), for: UIControl.Event.touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	init(viewModel: DetailMovieVCModel, navigator: ListDetailNavigator) {
		self.viewModel = viewModel
		self.navigator = navigator
		super.init(nibName: nil, bundle: nil)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	required init?(coder aDecoder: NSCoder) {
		return nil
	}
	
	override func viewDidLoad() {
		setupView()
		loadMovie()
		super.viewDidLoad()
	}
	
	@objc func favoriteButtonPressed(){
		validate(favorite: viewModel.toggleFavorite())
	}
	
}

extension DetailMovieVC {
	func loadMovie(){
		self.viewModel.provideDetailedMetadata { (movie, genres, favorite, error) in
			if let error = error {
				print(error.localizedDescription)
			} else {
				if let movie = movie, let genres = genres {
					let genreNames = genres.map({ $0.name })
					
					self.backgroundImage.kf.setImage(with: movie.posterImageURL())
					self.titleLabel.text = movie.title
					self.yearLabel.text = movie.yearDescription
					self.genresLabel.text = "(\(genreNames.compactMap({$0}).joined(separator: ", ")))"
					self.overviewLabel.text = movie.overview
					
					self.validate(favorite: favorite)
				}
			}
		}
	}
	
	func validate(favorite: Bool){
		if favorite == true {
			favoriteButton.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal)
		} else {
			favoriteButton.setImage(#imageLiteral(resourceName: "favorite_empty_icon"), for: .normal)
		}
	}
}

extension DetailMovieVC: CodeView {
	func buildViewHierarchy() {
		view.addSubview(backgroundImage)
		view.addSubview(titleLabel)
		view.addSubview(yearLabel)
		view.addSubview(genresLabel)
		view.addSubview(overviewLabel)
		view.addSubview(favoriteButton)
	}
	
	func setupConstraints() {
		backgroundImage.sizeToFit()
		backgroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
		backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
		backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
		backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
		
		titleLabel.sizeToFit()
		titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
		titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
		titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
		
		yearLabel.sizeToFit()
		yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
		yearLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
		yearLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
		
		genresLabel.sizeToFit()
		genresLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 0).isActive = true
		genresLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
		genresLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
		
		overviewLabel.sizeToFit()
		overviewLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
		overviewLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
		overviewLabel.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
		
		favoriteButton.sizeToFit()
		favoriteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
		favoriteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
		favoriteButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, constant: 24).isActive = true
		favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor).isActive = true
	}
	
	func setupAdditionalConfiguration() {
		setupMainView()
		setupNavigationItem()
		setupLabelsAlignment()
	}
	
	func setupMainView(){
		self.view.backgroundColor = UIColor.black
	}
	
	func setupLabelsAlignment(){
		genresLabel.textAlignment = .right
		overviewLabel.textAlignment = .justified
		
	}
	
	func setupNavigationItem(){
		if let image = UIImage(named: "logo") {
			let imageView = UIImageView(image: image)
			imageView.contentMode = .scaleAspectFit
			
			navigationItem.titleView = imageView
		}
	}
}
