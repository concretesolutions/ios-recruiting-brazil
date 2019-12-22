//
//  CoreDataErrors.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

enum CoreDataErrors: Error {
    case movieIsAlreadyFaved
    case cannotFindMovieWithID(Int)
}
