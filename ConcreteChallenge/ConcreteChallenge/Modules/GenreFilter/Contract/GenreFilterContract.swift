//
//  GenreFilterContract.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

protocol GenreFilterWireframe: class {
    var viewController: UIViewController? { get set }
    static var presenter: GenreFilterPresentation! { get set }
    
    static func assembleModule() -> UIViewController
    
    func didTapSaveButton()
}

protocol GenreFilterView {
    var presenter: GenreFilterPresentation! { get set }
    
    func showGenres(genres: [Genre])
}

protocol GenreFilterPresentation: class {
    var view: GenreFilterView? { get set }
    var interactor: GenreFilterInteractorInput! { get set }
    var router: GenreFilterWireframe! { get set }
    
    var datesFilter: [Date] { get set }
    
    func viewDidLoad()
    func didSelectGenre(genre: Genre)
    func didDeselectGenre(genre: Genre)
    func didTapSaveButton()
}

protocol GenreFilterInteractorInput: class {
    var output: GenreFilterInteractorOutput! { get set }
    
    func getGenres()
    func saveGenreFilter(genre: Genre)
}

protocol GenreFilterInteractorOutput: class {
    func didGetGenres(genres: [Genre])
}


