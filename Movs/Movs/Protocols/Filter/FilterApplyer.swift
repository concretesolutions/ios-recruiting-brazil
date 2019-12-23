//
//  FilterApplyer.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 22/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

protocol FilterApplyer: class {

    // MARK: - properties

    var isFiltering: Bool { get set }
    var filteredMovies: [Movie] { get set }

    // MARK: - Update methods

    func updateData()
}
