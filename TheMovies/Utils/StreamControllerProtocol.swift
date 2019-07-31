//
//  StreamControllerProtocol.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/30/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Foundation

protocol StreamControllerProtocol {
    func setupPresenterStreams()
    func setupViewStreams()
    func setupLocalStreams()
}

extension StreamControllerProtocol {
    func setupStreams() {
        self.setupLocalStreams()
        self.setupViewStreams()
        self.setupPresenterStreams()
    }
}
