//
//  DelegateSetFavorite.swift
//  AppMovie
//
//  Created by Renan Alves on 25/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

protocol FavoriteDelegate {
    func setFavorite(movie: MovieNowPlaying)
    func removeFavorite(movie: MovieNowPlaying)
}
