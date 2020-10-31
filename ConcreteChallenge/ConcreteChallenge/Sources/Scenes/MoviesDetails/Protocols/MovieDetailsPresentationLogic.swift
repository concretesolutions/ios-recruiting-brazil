//
//  MovieDetailsPresentationLogic.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol MovieDetailsPresentationLogic: AnyObject {
    func onSuccessSaveMovie(response: MovieDetails.SaveMovie.Response)
    func onSuccessDeleteMovie(response: MovieDetails.DeleteMovie.Response)
}
