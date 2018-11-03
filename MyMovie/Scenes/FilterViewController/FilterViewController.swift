//
//  FilterViewController.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 21/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//


import UIKit

let menuArray : [String] = ["Genres", "Date"]

class FilterViewController: UIViewController {
	
	@IBOutlet weak var myTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		myTableView.dataSource = self
		myTableView.delegate = self
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.setBackgroundColor()
		self.setConfigNavigation()
		
	}
	
	//MARK: Sets
	private func setBackgroundColor() {
		self.view.backgroundColor = MyMovieUIKit.background
	}
	
	private func setConfigNavigation(){
		navigationItem.title = "Filter"
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
	}
}

extension FilterViewController:UITableViewDelegate{
	
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 0
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if(indexPath.row == 0){
			performSegue(withIdentifier: "filterGenre", sender: nil)
		}else{
			performSegue(withIdentifier: "filterDate", sender: nil)
		}
	}
	
}

extension FilterViewController:UITableViewDataSource{
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return menuArray.count
		
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellFilter", for: indexPath) as! FilterTableViewCell
		
			cell.filter.text = menuArray[indexPath.row]
		
		return cell
		
	}
	
}
