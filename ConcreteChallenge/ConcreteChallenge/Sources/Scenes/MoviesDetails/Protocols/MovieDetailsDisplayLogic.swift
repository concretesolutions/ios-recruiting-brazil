//
//  MovieDetailsDisplayLogic.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol MovieDetailsDisplayLogic: AnyObject {
    func onSuccessSaveMovie(viewModel: MovieDetails.SaveMovie.ViewModel)
    func onSuccessDeleteMovie(viewModel: MovieDetails.DeleteMovie.ViewModel)
}
