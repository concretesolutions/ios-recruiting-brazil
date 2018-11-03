//
//  MovieViewController.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 20/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//


import UIKit

class MovieViewController: UIViewController {
	
	let imageUrl = BASE_IMAGE_URL
	fileprivate let itemHeight: CGFloat = 270
	fileprivate let itemsPerRow: CGFloat = 2
	fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 50.0, right: 20.0)
	
	@IBOutlet var viewErro: UIView!
	@IBOutlet weak var erroLb: UILabel!
	@IBOutlet weak var imageErro: UIImageView!
	
	
	@IBOutlet weak var loading: UIActivityIndicatorView!
	
	var filteredMovie:[Movie] = []
	var arrayMovies: [Movie] = []
	var searchActive : Bool = false
	var controlQtdFeed = QTD_MOVIE
	var qtdPage = QTD_PAGE
	
	@IBOutlet weak var mySearchBar: UISearchBar!
	@IBOutlet weak var collectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.loading.isHidden = false
		self.loading.startAnimating()
		
		
		self.collectionView.dataSource = self
		self.collectionView.delegate = self
		self.mySearchBar.delegate = self


	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.loadData()
		self.setBackgroundColor()
		self.setConfigNavigation()
		
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
	}
	
	private func loadData(){
		
		self.erroLb.text = "An error occurred, please try again later"
		self.imageErro.image = UIImage(named: "erroIcon")
		
		Requester.getMovies(page: self.qtdPage, qtdeMovies: 1) { (success, error) in
			if(success){
				self.arrayMovies = Singleton.sharedInstance.movies
				self.filteredMovie = self.arrayMovies
				
				self.qtdPage = self.qtdPage + 1
				self.collectionView.reloadData()
			}
			self.hiddenTable()
		}
		
	}
	
	private func hiddenTable(){
		
		if( self.arrayMovies.isEmpty){
			
			self.erroLb.isHidden = false
			self.imageErro.isHidden = false
		}
		else{
			
			self.collectionView.isHidden = false
			self.erroLb.isHidden = true
			self.imageErro.isHidden = true
		}
		
		self.loading.stopAnimating()
		self.loading.isHidden = true
		
	}
	
	private func setBackgroundColor() {
		self.view.backgroundColor = MyMovieUIKit.background
		self.collectionView.backgroundColor = MyMovieUIKit.background
		self.mySearchBar.barTintColor = MyMovieUIKit.background
	}
	
	private func setConfigNavigation(){
		navigationItem.title = "Movies"
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let movie = sender as? Movie, (segue.identifier == "detailMovie") {
			if let detailVC = segue.destination as? DetailMovieViewController {
				detailVC.myMovie = movie
				
			}
		}
	}
	
	func downloadImage(from url: URL, cell: MovieCollectionViewCell) {
		//print("Download Started")
		getData(from: url) { data, response, error in
			guard let data = data, error == nil else { return }
			print(response?.suggestedFilename ?? url.lastPathComponent)
			//print("Download Finished")
			DispatchQueue.main.async() {
				cell.posterMovie.image = UIImage(data: data)
			}
		}
	}
	
	func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
		URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
	}
	
}

extension MovieViewController: UISearchBarDelegate{
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.mySearchBar.endEditing(true)
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText.isEmpty {
			self.filteredMovie = self.arrayMovies
		} else {
			self.filteredMovie = self.arrayMovies.filter({ (movie) -> Bool in
				movie.title?.lowercased().contains(searchText.lowercased()) ?? false
			})
		}
		
		
		if(filteredMovie.isEmpty){
			
			self.erroLb.text = "Your search for "+searchText+" did not match any results."
			self.imageErro.image = UIImage(named: "searchIcon")
			self.erroLb.isHidden = false
			self.imageErro.isHidden = false
			
		}else{
			self.erroLb.isHidden = true
			self.imageErro.isHidden = true
			self.collectionView.isHidden = false
		}
		
		self.collectionView.reloadData()
	}
	
	
}

extension MovieViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		let screenWidth = UIScreen.main.bounds.width
		
		let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
		let availableWidth = screenWidth - paddingSpace
		let widthPerItem = availableWidth / itemsPerRow
		
		return CGSize(width: widthPerItem, height: itemHeight)
	}
	
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						insetForSectionAt section: Int) -> UIEdgeInsets {
		return sectionInsets
	}
	
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return sectionInsets.left
	}
	
}


extension MovieViewController: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int{
		return 1;
	}
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
		return self.filteredMovie.count
	}
	
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! MovieCollectionViewCell
		
		// Config Cell
		
		cell.layer.borderColor = UIColor.black.cgColor
		cell.layer.borderWidth = 1
		cell.clipsToBounds = true
		
		cell.layer.masksToBounds = true;
		cell.layer.cornerRadius = 6;
		cell.posterMovie.contentMode = .scaleAspectFit
		
		//Loading itens
		if let poster = filteredMovie[indexPath.row].poster {
			if let url = URL(string: self.imageUrl+poster) {
				downloadImage(from: url, cell: cell)
			}
		}
		cell.titleLb.text = filteredMovie[indexPath.row].title
		
		let dbMovie = MovieProvider.init().get(filteredMovie[indexPath.row].movieID)
		if dbMovie != nil{
			cell.favorite.setImage(UIImage(named: "favoriteFull-Icon"), for: UIControl.State.normal)
			filteredMovie[indexPath.row].favorite = 1
		}else{
			cell.favorite.setImage(UIImage(named: "favoriteEmptyIcon"), for: UIControl.State.normal)
		}
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		
		if(indexPath.row == arrayMovies.count - 1){
			Requester.getMovies(page: self.qtdPage, qtdeMovies: QTD_ADD_MOVIE, completionHandler: { (success, error) in
				
				if(success){
					
					self.qtdPage = self.qtdPage + 1
					self.arrayMovies = Singleton.sharedInstance.movies
					self.filteredMovie = self.arrayMovies
					
					self.collectionView.reloadData()
					self.erroLb.isHidden = true
					
				}else{
					self.erroLb.isHidden = false
				}
				self.hiddenTable()
			})
		}
	}
	
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		self.mySearchBar.endEditing(true)
	}
	
}

extension MovieViewController: UICollectionViewDelegate{
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		performSegue(withIdentifier: "detailMovie", sender: filteredMovie[indexPath.row])
		
	}
}


