//
//  FilterGenreViewController.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 31/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//

import UIKit

class FilterGenreViewController: UIViewController {
	
	@IBOutlet weak var myTableView: UITableView!
	var arrayGenres: [Genre] = []
	var arrayGenresInt: [Int] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		myTableView.dataSource = self
		myTableView.delegate = self
		
    }
    
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.loadData()
		myTableView.allowsMultipleSelection = true
		self.setBackgroundColor()
		self.setConfigNavigation()
		

	}
	
	private func loadData(){
		if(Singleton.sharedInstance.genres.isEmpty){
			Requester.getGenre(completionHandler: { (success, error) in
				if(success){
					self.arrayGenres = Singleton.sharedInstance.genres
					
				}
			})
		}else{
			
			self.arrayGenres = Singleton.sharedInstance.genres
		}
	}
	
	
	private func setBackgroundColor() {
		self.view.backgroundColor = MyMovieUIKit.background
	}
	
	private func setConfigNavigation(){
		navigationItem.title = "Filter Genres"
		let buttonFilter = UIBarButtonItem(image: UIImage(named: "doneIcon"), style: .plain, target: self, action: #selector(segueToFilter))
		
		self.navigationItem.rightBarButtonItem  = buttonFilter
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
	}
	
	@objc func segueToFilter(){
		
		performSegue(withIdentifier: "favoriteMovie", sender: nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.identifier == "favoriteMovie" {
			if let favoriteController = segue.destination as? FavoriteViewController {
				favoriteController.myArrayGenres = self.arrayGenresInt
				favoriteController.myFlagFilter = FLAG_GENRE
				
			}
		}
	}
	
}

extension FilterGenreViewController:UITableViewDelegate{
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.arrayGenresInt.append(arrayGenres[indexPath.row].genreID)
		
	}
	
	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		arrayGenresInt = arrayGenresInt.filter { $0 != arrayGenres[indexPath.row].genreID }
		
		print(arrayGenresInt)
	}
}

extension FilterGenreViewController:UITableViewDataSource{
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return arrayGenres.count
		
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellFilter", for: indexPath) as! FilterGenreTableViewCell
		
		cell.filter.text = arrayGenres[indexPath.row].name
		
		return cell
		
	}
	
}
