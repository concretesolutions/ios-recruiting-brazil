//
//  AppDelegate+DISetup.swift
//  ViperitTest
//
//  Created by Matheus Bispo on 7/25/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Foundation
import Swinject

extension AppDelegate {
    //Method responsible for configurating all class dependencies
    func setupDI() {
        
        // MARK:- PRESENTATION -
        // Criando factories das instâncias de apresentação que serão utilizadas no app
        
        container.register(RootTabBarPresentation.self) {
            resolver in
            return RootTabBarPresentation.build(with: resolver)
        }
        
        container.register(MoviesGridPresentation.self) {
            resolver in
            return MoviesGridPresentation.build(with: self.container)
        }
        
        container.register(FavoriteMoviesPresentation.self) {
            resolver in
            return FavoriteMoviesPresentation.build(with: resolver)
        }
        
        // MARK:- DATA -
        // Criando factories das instâncias de repositório que serão utilizadas no app
        
        container.register(MovieNetworkRepositoryProtocol.self) {
            resolver in
            return MovieNetworkRepository(service: TheMovieServiceAPI())
        }.inObjectScope(.container)
        
        container.register(MovieMemoryRepositoryProtocol.self) {
            resolver in
            return MovieMemoryRepository()
            }.inObjectScope(.container)
        
        container.register(GenreNetworkRepositoryProtocol.self) {
            resolver in
            return GenreNetworkRepository(service: TheMovieServiceAPI())
        }.inObjectScope(.container)
        
        container.register(GenreMemoryRepositoryProtocol.self) {
            resolver in
            return GenreMemoryRepository()
        }.inObjectScope(.container)
        
    }
}
