//
//  FavoriteViewController.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 20/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
	
	
	@IBOutlet weak var lbErro: UILabel!
	@IBOutlet weak var imageErro: UIImageView!
	
	@IBOutlet weak var removeFilterHeight: NSLayoutConstraint!
	@IBOutlet weak var removeFilterBnt: UIButton!
	@IBOutlet weak var myTableView: UITableView!
	@IBOutlet weak var mySearchBar: UISearchBar!
	
	var arrayMovies: [Movie] = []
	var filteredMovie: [Movie] = []
	
	var myFilter: String?
	var myArrayGenres: [Int] = []
	
	var myFlagFilter: Int?
	
	let imageUrl = BASE_IMAGE_URL
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.myTableView.dataSource = self
		self.myTableView.delegate = self
		self.mySearchBar.delegate = self
		
		self.loadMyButton()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.setBackgroundColor()
		self.setConfigNavigation()
		
		switch self.myFlagFilter {
		case FLAG_GENRE:
			self.loadGenreByMyFilter()
		case FLAG_DATE:
			self.loadDataByMyFilter()
		default:
			self.myLoadData()
		}
		
	}
	
	private func loadMyButton(){
		if(self.myFlagFilter == FLAG_GENRE || self.myFlagFilter == FLAG_DATE){
			self.removeFilterHeight.constant = 100
			self.removeFilterBnt.isEnabled = true
		}else{
			self.hiddenFilterButton()
		}
		self.view.setNeedsDisplay()
	}
	
	private func loadGenreByMyFilter(){
		self.arrayMovies = MovieProvider.init().values
		var myMovieList = Set<Movie>()
		
		for movie in self.arrayMovies {
			var occurr = 0
			for genre in self.myArrayGenres{
				for genreInMovie in movie.genres{
					if(genreInMovie == genre){
						occurr = occurr + 1
					}
				}
			}
			if(occurr > 0){
				myMovieList.insert(movie)
			}
		}
		
		self.filteredMovie = Array<Movie>(myMovieList)
		self.myTableView.reloadData()
	}
	
	private func loadDataByMyFilter(){
		self.arrayMovies = MovieProvider.init().values
		for movie in arrayMovies {
			let dateComponents = movie.releaseDate?.components(separatedBy: "-")
			if let year = dateComponents?.first {
				if (year == self.myFilter){
					self.filteredMovie.append(movie)
				}
			}
		}
	}
	
	
	private func hiddenFilterButton(){
		self.removeFilterHeight.constant = 0
		self.removeFilterBnt.isEnabled = false
	}
	
	private func myLoadData(){
		self.arrayMovies = MovieProvider.init().values
		self.filteredMovie = self.arrayMovies
		self.myTableView.reloadData()
	}
	
	@IBAction func myRemoveFilterBnt(_ sender: Any) {
		self.myFlagFilter = 0
		self.myFilter = ""
		self.filteredMovie = self.arrayMovies
		self.myTableView.reloadData()
		self.loadMyButton()
	}
	
	private func setBackgroundColor() {
		self.myTableView.backgroundView?.backgroundColor = MyMovieUIKit.background
		self.view.backgroundColor = MyMovieUIKit.background
		self.mySearchBar.barTintColor = MyMovieUIKit.background
	}
	
	private func setConfigNavigation(){
		navigationItem.title = "Favorites"
		let buttonFilter = UIBarButtonItem(image: UIImage(named: "filterIcon"), style: .plain, target: self, action: #selector(segueToFilter))
		
		self.navigationItem.rightBarButtonItem  = buttonFilter
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let movie = sender as? Movie, (segue.identifier == "detailMovie") {
			if let detailVC = segue.destination as? DetailMovieViewController {
				detailVC.myMovie = movie
				
			}
		}
	}
	
	
	func downloadImage(from url: URL, cell: FavoriteTableViewCell) {
		//print("Download Started")
		getData(from: url) { data, response, error in
			guard let data = data, error == nil else { return }
			print(response?.suggestedFilename ?? url.lastPathComponent)
			//print("Download Finished")
			DispatchQueue.main.async() {
				cell.moviePoster.image = UIImage(data: data)
			}
		}
	}
	
	func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
		URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
	}
	
	@objc func segueToFilter(){
		performSegue(withIdentifier: "filterMovie", sender: nil)
	}
	
}


extension FavoriteViewController:UITableViewDelegate{
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			
			MovieProvider.init().delete(self.filteredMovie[indexPath.row])
			self.arrayMovies = MovieProvider.init().values
			self.filteredMovie = self.arrayMovies
			tableView.reloadData()
			
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "detailMovie", sender: self.filteredMovie[indexPath.row])
	}
	
	func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
	{
		return "Unfavorite"
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 0
	}
	
}


extension FavoriteViewController: UISearchBarDelegate{
	
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
			self.myTableView.isHidden = true
			self.lbErro.text = "Your search for "+searchText+" did not match any results."
			self.imageErro.image = UIImage(named: "searchIcon")
			self.lbErro.isHidden = false
			self.imageErro.isHidden = false
			
		}else{
			self.lbErro.isHidden = true
			self.imageErro.isHidden = true
			self.myTableView.isHidden = false
		}
		
		self.myTableView.reloadData()
	}
}


extension FavoriteViewController:UITableViewDataSource{
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.filteredMovie.count
		
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "myTableViewCell", for: indexPath) as! FavoriteTableViewCell
		
		cell.backgroundColor = UIColor.white
		cell.layer.borderColor = UIColor.black.cgColor
		cell.layer.borderWidth = 1
		cell.clipsToBounds = true
		cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
		
		cell.descriptionLb.text = self.filteredMovie[indexPath.row].descriptionMovie
		cell.titleLb.text = self.filteredMovie[indexPath.row].title
		cell.releaseLb.text = self.filteredMovie[indexPath.row].releaseDate
		if let poster = self.filteredMovie[indexPath.row].poster {
			if let url = URL(string: self.imageUrl+poster) {
				downloadImage(from: url, cell: cell)
			}
		}
		return cell
		
	}
	
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		self.mySearchBar.endEditing(true)
	}
}
