//
//  FavoritesFilterVC.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 24/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain
import Eureka

struct FilterFormTags {
	static let genres = (tag: "genres", title: "Gênero")
	static let yearOfReleases = (tag: "yearOfReleases", title: "Ano de Lançamento")
}

final class FavoritesFilterVC: FormViewController {
	let navigator: FavoritesFilterNavigator
	let viewModel: FavoritesFilterVCModel
	
	var confirmButton: UIButton = {
		let view = UIButton(frame: .zero)
		view.backgroundColor = .orange
		view.tintColor = .white
		view.setTitle("Confirmar", for: UIControl.State.normal)
		view.addTarget(self, action: #selector(confirmButtonAction), for: UIControl.Event.touchUpInside)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	func setupForm() {
		viewModel.registerFormController(formController: self)
		
		form = Form()
		form +++ Section("")
			<<< MultipleSelectorRow<Genre>(){
				$0.tag = FilterFormTags.genres.tag
				$0.title = FilterFormTags.genres.title
				$0.options = viewModel.filter.genres
				$0.displayValueFor = { genres in
					if let uGenres = genres {
						return "(\(uGenres.map({ $0.name }).joined(separator: ", ") ))"
					}
					return ""
				}
				$0.selectorTitle = "Selecione os Gêneros"
				}.onPresent({ (form, to) in
					to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.multipleSelectorDone(_:)))
					to.selectableRowCellSetup = { cell, row in
						if let item = row.selectableValue {
							row.title = item.name
						}
					}
				})
			<<< MultipleSelectorRow<Int>(){
				$0.tag = FilterFormTags.yearOfReleases.tag
				$0.title = FilterFormTags.yearOfReleases.title
				$0.options = viewModel.filter.yearOfReleases.sorted(by: { $0 > $1 })
				$0.displayValueFor = { years in
					if let uYears = years?.sorted() {
						return "(\(uYears.map({"\($0.yearDescription)"}).joined(separator: ", ")))"
					}
					return ""
				}
				$0.selectorTitle = "Selecione os Anos de Lançamento"
				}.onPresent({ (form, to) in
					to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.multipleSelectorDone(_:)))
					to.selectableRowCellSetup = { cell, row in
						if let item = row.selectableValue {
							row.title = item.yearDescription
                        }
					}
				})
		form = form
	}
	
	init(navigator: FavoritesFilterNavigator, viewModel: FavoritesFilterVCModel) {
		self.navigator = navigator
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		return nil
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupForm()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	@objc func confirmButtonAction(){
		let filter = viewModel.confirmedFilter()
		navigator.dismissToFavoritesList(filter: filter)
	}
}

extension FavoritesFilterVC: CodeView {
	func buildViewHierarchy() {
		view.addSubview(confirmButton)
	}
	
	func setupConstraints() {
		confirmButton.sizeToFit()
		confirmButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
		confirmButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
		confirmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
		confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
	}
	
	func setupAdditionalConfiguration() {
		setupNavigationItem()
		self.view.backgroundColor = .white
	}
	
	func setupNavigationItem(){
		if let image = UIImage(named: "logo") {
			let imageView = UIImageView(image: image)
			imageView.contentMode = .scaleAspectFit
			
			navigationItem.titleView = imageView
			navigationItem.backBarButtonItem?.title = "Cancelar"
		}
	}
	
	@objc func multipleSelectorDone(_ item:UIBarButtonItem) {
		_ = navigationController?.popViewController(animated: true)
	}
}
