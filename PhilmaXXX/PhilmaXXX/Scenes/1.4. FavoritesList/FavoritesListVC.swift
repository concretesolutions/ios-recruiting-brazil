//
//  FavoritesListVC.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 24/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain

final class FavoritesListVC: UIViewController {
	
	let navigator: FavoritesNavigator
	let viewModel: FavoritesListVCModel
	
	lazy var searchBar: UISearchBar = {
		let view = UISearchBar(frame: .zero)
		view.placeholder = "Busque um filme pelo nome ou ano"
		view.barStyle = UIBarStyle.black
		view.returnKeyType = UIReturnKeyType.default
		view.translatesAutoresizingMaskIntoConstraints = false
		
		viewModel.registerSearchBar(view: view)
		view.delegate = viewModel.registerSearchBarDelegate()
		
		return view
	}()
	
	lazy var filterBarButton: UIBarButtonItem = {
		let view = UIBarButtonItem(image: #imageLiteral(resourceName: "FilterIcon"), style: .plain, target: self, action: #selector(pushFilterAction))
		return view
	}()
	
	var removeFilter: UIButton = {
		let view = UIButton(frame: .zero)
		view.addTarget(self, action: #selector(removeFilterAction), for: UIControl.Event.touchUpInside)
		view.setTitle("Remover filtro", for: .normal)
		view.backgroundColor = UIColor.darkGray
		view.titleLabel?.textColor = UIColor.yellow
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	lazy var tableView: UITableView = {
		let view = UITableView(frame: .zero, style: UITableView.Style.plain)
		view.backgroundColor = .clear
		view.register(UINib(nibName: "MovieTableViewCell", bundle: Bundle.main) , forCellReuseIdentifier: "MovieTableViewCell")
		view.separatorColor = .clear
		view.bounces = false
		
		viewModel.registerTable(view: view)
		view.delegate = viewModel.registerTableViewDelegate()
		view.dataSource = viewModel.registerTableViewDataSource()
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	lazy var filterBottomConstraint: NSLayoutConstraint = {
		if (viewModel.filter == nil){
			return removeFilter.heightAnchor.constraint(equalToConstant: 0)
		} else {
			return removeFilter.heightAnchor.constraint(equalToConstant: 48)
		}
	}()
	
	init(navigator: FavoritesNavigator, viewModel: FavoritesListVCModel){
		self.navigator = navigator
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		
		viewModelSetup()
	}
	
	func viewModelSetup(){
		viewModel.pushToDetail = { movie, bool in
			self.navigator.toDetailMovie(movie, favorite: bool)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		return nil
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		filterBottomConstraint.isActive = true
		self.setupView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		viewModel.reloadTableView()
		decideFilterButton()
	}
	
	@objc func pushFilterAction(){
		if let filter = viewModel.baseFilter {
			navigator.toFavoritesFilter(filter: filter)
		}
	}
	
	@objc func removeFilterAction(){
		hideRemoveFilterButton()
		viewModel.filter = nil
		viewModel.reloadTableView()
	}
	
}

extension FavoritesListVC: CodeView {
	func buildViewHierarchy() {
		view.addSubview(searchBar)
		view.addSubview(removeFilter)
		view.addSubview(tableView)
	}
	
	func setupConstraints() {
		searchBar.sizeToFit()
		searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
		searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
		searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
		searchBar.heightAnchor.constraint(equalToConstant: 48).isActive = true
		
		removeFilter.sizeToFit()
		removeFilter.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
		removeFilter.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
		removeFilter.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
		
		tableView.sizeToFit()
		tableView.topAnchor.constraint(equalTo: removeFilter.bottomAnchor, constant: 0).isActive = true
		tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
		tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
	}

	private func decideFilterButton(){
		if (self.viewModel.filter == nil){
			hideRemoveFilterButton()
		} else {
			showRemoveFilterButton()
		}
	}
	
	private func hideRemoveFilterButton(){
		removeFilter.isHidden = true
		filterBottomConstraint.constant = 0
	}
	
	private func showRemoveFilterButton(){
		removeFilter.isHidden = false
		filterBottomConstraint.constant = 48
	}
	
	func setupAdditionalConfiguration() {
		setupMainView()
		setupNavigationItem()
	}
	
	func setupMainView(){
		self.view.backgroundColor = UIColor.darkGray
	}

	func setupNavigationItem(){
		if let image = UIImage(named: "logo") {
			let imageView = UIImageView(image: image)
			imageView.contentMode = .scaleAspectFit
			
			navigationItem.titleView = imageView
		}
		navigationItem.rightBarButtonItem = filterBarButton
	}

}
