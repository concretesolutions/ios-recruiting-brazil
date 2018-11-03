//
//  DetailMovieViewController.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 21/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {
	
	
	@IBOutlet weak var moviePost: UIImageView!
	@IBOutlet weak var descriptionLb: UILabel!
	@IBOutlet weak var genreLb: UILabel!
	@IBOutlet weak var releaseLb: UILabel!
	@IBOutlet weak var titleLb: UILabel!
	@IBOutlet weak var favoriteBnt: UIButton!
	
	
	var myMovie: Movie?
	var arrayGenres: [Genre] = []
	
	var favoriteButtonTapped: ((_ button: UIButton) -> ())?
	let imageUrl = BASE_IMAGE_URL
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.loadGenres()
		self.loadData()
	}
	
	private func loadData(){
		
		if let movie = myMovie {
			
			if let poster = myMovie!.poster {
				if let url = URL(string: self.imageUrl+poster) {
					downloadImage(from: url)
				}
			}
			
			favoriteBnt.addTarget(self, action: #selector(favoritePressed), for: .touchUpInside)
			self.descriptionLb.text = movie.descriptionMovie
			self.titleLb.text = movie.title
			self.releaseLb.text = movie.releaseDate
			
		}
	}
	
	
	private func loadGenres(){
		if(Singleton.sharedInstance.genres.isEmpty){
			Requester.getGenre(completionHandler: { (success, error) in
				if(success){
					self.arrayGenres = Singleton.sharedInstance.genres
					self.getGenreDescription()
				}
			})
		}else{
			
			self.arrayGenres = Singleton.sharedInstance.genres
			self.getGenreDescription()
		}
		
	}
	
	
	private func getGenreDescription(){
		
		if let movie = myMovie{
			var genreDescripton = ""
			for genre in self.arrayGenres {
				for idGenre in movie.genres{
					if(idGenre == genre.genreID){
						genreDescripton.append(contentsOf: "\((genre.name ?? "")), " )
					}
				}
			}
			self.genreLb.text = genreDescripton
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.loadImageButton()
		self.setBackgroundColor()
		self.setConfigNavigation()
		
	}
	
	private func loadImageButton(){
		
		if let movie = myMovie {
			
			if movie.favorite == 0 {
				favoriteBnt.setImage(UIImage(named: "favoriteEmptyIcon"), for: UIControl.State.normal)
			} else {
				favoriteBnt.setImage(UIImage(named: "heart-red-icon"), for: UIControl.State.normal)
			}
		}
	}
	
	@objc func favoritePressed(sender: Any){
		
		if var movie = self.myMovie {
			
			if movie.favorite == 1 {
				favoriteBnt.setImage(UIImage(named: "favoriteEmptyIcon"), for: UIControl.State.normal)
				movie.favorite = 0
				self.myMovie = movie
				MovieProvider.init().delete(movie)
			} else {
				favoriteBnt.setImage(UIImage(named: "heart-red-icon"), for: UIControl.State.normal)
				movie.favorite = 1
				self.myMovie = movie
				MovieProvider.init().insert(movie)
			}
		}
	}
	
	private func setBackgroundColor() {
		self.view.backgroundColor = MyMovieUIKit.background
	}
	
	private func setConfigNavigation(){
		navigationItem.title = "Detail Movie"
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
	}
	
	func downloadImage(from url: URL) {
		getData(from: url) { data, response, error in
			guard let data = data, error == nil else { return }
			print(response?.suggestedFilename ?? url.lastPathComponent)
			DispatchQueue.main.async() {
				self.moviePost.image = UIImage(data: data)
			}
		}
	}
	
	func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
		URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
	}
}
