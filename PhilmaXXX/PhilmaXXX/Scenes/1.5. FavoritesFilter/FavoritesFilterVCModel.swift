//
//  FavoritesFilterVCModel.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 24/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import UIKit
import Domain
import Eureka

final class FavoritesFilterVCModel: NSObject {
	public let filter: Filter
	
	weak var formController: FormViewController?
	
	init(filter: Filter) {
		self.filter = filter
	}
	
	public func confirmedFilter() -> Filter? {
		return retrieveFilter()
	}
	
	private func retrieveFilter() -> Filter? {
		if let formController = formController {
			let genres = formController.form.rowBy(tag: FilterFormTags.genres.tag)?.baseValue as? Set<Genre> ?? Set<Genre>()
			let yearOfReleases = formController.form.rowBy(tag: FilterFormTags.yearOfReleases.tag)?.baseValue as? Set<Int> ?? Set<Int>()
			
			if (!genres.isEmpty || !yearOfReleases.isEmpty){
				return Filter(genres: Array(genres), yearOfReleases: Array(yearOfReleases))
			} else {
				return nil
			}
		}
		return nil
	}
	
}

extension FavoritesFilterVCModel {
	public func registerFormController(formController: FormViewController){
		self.formController = formController
	}
}
