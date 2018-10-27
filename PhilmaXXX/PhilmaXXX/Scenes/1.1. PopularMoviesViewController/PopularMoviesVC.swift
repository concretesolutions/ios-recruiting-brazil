//
//  PopularMoviesVC.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 21/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import UIKit

final class PopularMoviesVC: UIViewController {
	
	let viewModel: PopularMoviesVCModel
	let navigator: ListNavigator
	
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
	
	var gridViewLayout: UICollectionViewLayout = {
		let layout = UICollectionViewFlowLayout()
		let margin = CGFloat(ScreenSize.width() * 0.05)
		layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
		layout.minimumLineSpacing = margin
		layout.minimumLineSpacing = margin
		return layout
	}()

	lazy var gridView: UICollectionView = {
		let view = UICollectionView(frame: .zero, collectionViewLayout: gridViewLayout)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .clear
		
		view.register(UINib(nibName: "MoviePosterCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "MoviePosterCollectionViewCell")
		
		view.dataSource = viewModel.registerGridDataSource()
		view.delegate = viewModel.registerGridDelegate()
		viewModel.registerGrid(collectionView: view)
		
		view.isHidden = true
		
		return view
	}()
	
	lazy var gridError: PopularMoviesErrorView = {
		let errorView = PopularMoviesErrorView(frame: .zero)
		errorView.translatesAutoresizingMaskIntoConstraints = false
		errorView.setup(viewModel: PopularMoviesErrorViewModel.standardError )
		
		viewModel.registerErrorFatal(view: errorView)
		errorView.isHidden = true
		
		return errorView
	}()
	
	lazy var gridNoResults: PopularMoviesErrorView = {
		let errorView = PopularMoviesErrorView(frame: .zero)
		let errorViewModel = PopularMoviesErrorViewModel.standard(searchText: searchBar.text ?? "")
		errorView.setup(viewModel: errorViewModel)
		errorView.translatesAutoresizingMaskIntoConstraints = false
		
		viewModel.registerErrorNoResults(view: errorView)
		errorView.isHidden = true
		
		return errorView
	}()
	
	lazy var activityIndicator: UIActivityIndicatorView = {
		let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
		activityIndicator.hidesWhenStopped = true
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		
		return activityIndicator
	}()
	
    override func viewDidLoad() {
		self.setupView()
        super.viewDidLoad()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.viewModel.refreshFavoriteMovies()
	}
	
	func viewModelSetup(){
		viewModel.pushToDetail = { movie, bool in
			self.navigator.toDetailMovie(movie, favorite: bool)
		}
		viewModel.startApplication()
	}

	init(viewModel: PopularMoviesVCModel, navigator: ListNavigator) {
		self.navigator = navigator
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		
		viewModelSetup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		return nil
	}
}

extension PopularMoviesVC: CodeView {
	func buildViewHierarchy() {
		view.addSubview(searchBar)
		view.addSubview(gridView)
		view.addSubview(gridError)
		view.addSubview(gridNoResults)
		view.addSubview(activityIndicator)
	}

	func setupConstraints() {
		searchBar.sizeToFit()
		searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
		searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
		searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
		searchBar.heightAnchor.constraint(equalToConstant: 48).isActive = true

		gridView.sizeToFit()
		gridView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
		gridView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
		gridView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
		gridView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

		gridError.sizeToFit()
		gridError.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
		gridError.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
		gridError.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
		gridError.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

		gridNoResults.sizeToFit()
		gridNoResults.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
		gridNoResults.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
		gridNoResults.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
		gridNoResults.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
		
		activityIndicator.sizeToFit()
		activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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
	}
}
