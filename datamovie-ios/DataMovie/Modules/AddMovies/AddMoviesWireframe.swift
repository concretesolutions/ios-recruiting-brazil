//
//  AddMoviesWireframe.swift
//  DataMovie
//
//  Created by Andre Souza on 14/08/2018.
//  Copyright (c) 2018 Andre. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class AddMoviesWireframe: BaseWireframe {

    // MARK: - Private properties -

    private let _storyboard = UIStoryboard(type: .addMovies)

    // MARK: - Module setup -

    init(_ circularTransiction: CircularTransition, _ movieListUpdateProtocol: MovieListUpdateProtocol) {
        let moduleViewController = _storyboard.instantiateViewController(ofType: AddMoviesViewController.self)
        circularTransiction.toDelegate = moduleViewController
        super.init(viewController: moduleViewController)
        
        let interactor = AddMoviesInteractor()
        let presenter = AddMoviesPresenter(wireframe: self, view: moduleViewController, interactor: interactor, movieListUpdateProtocol: movieListUpdateProtocol)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension AddMoviesWireframe: AddMoviesWireframeInterface {

    func navigate(to option: AddMoviesNavigationOption) {
    }
}
