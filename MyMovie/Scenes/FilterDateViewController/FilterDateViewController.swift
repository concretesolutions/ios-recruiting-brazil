//
//  FilterDateViewController.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 31/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//

import UIKit

class FilterDateViewController: UIViewController {
	
	@IBOutlet weak var myTableView: UITableView!
	var arrayDate: [String] = []
	var arrayMovies: [Movie] = []
	var myFilter: String?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.myTableView.delegate = self
		self.myTableView.dataSource = self
      
    }
    
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.loadData()
		self.setBackgroundColor()
		self.setConfigNavigation()
		
	}
	
	private func loadData(){
		arrayMovies = MovieProvider.init().values
		var myYearRelease = Set<String>()
		for movie in arrayMovies {
			let dateComponents = movie.releaseDate?.components(separatedBy: "-")
			if let year = dateComponents?.first {
				myYearRelease.insert(year)
			}
		}
		
		self.arrayDate = Array<String>(myYearRelease).sorted()
		self.myTableView.reloadData()
	}

	private func setBackgroundColor() {
		self.view.backgroundColor = MyMovieUIKit.background
	}
	
	private func setConfigNavigation(){
		navigationItem.title = "Filter Date"
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
				favoriteController.myFilter = self.myFilter
				favoriteController.myFlagFilter = FLAG_DATE
				
			}
		}
	}

}

extension FilterDateViewController:UITableViewDelegate{
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.myFilter = self.arrayDate[indexPath.row]
	}
}

extension FilterDateViewController:UITableViewDataSource{
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.arrayDate.count
		
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellDate", for: indexPath) as! FilterDateTableViewCell
		
		cell.filter.text = self.arrayDate[indexPath.row]
		
		return cell
		
	}
	
}
