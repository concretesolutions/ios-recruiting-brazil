//
//  GenresFilterDelegate.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 22/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

protocol GenresFilterDelegate: class {

    // MARK: - properties

    var genres: [Int: String] { get }
    var tempSelectedGenreIds: Set<Int> { get set }
}
