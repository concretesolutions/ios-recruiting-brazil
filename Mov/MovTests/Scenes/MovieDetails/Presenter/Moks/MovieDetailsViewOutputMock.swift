//
//  MovieDetailsViewOutputMock.swift
//  MovTests
//
//  Created by Miguel Nery on 03/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation
@testable import Mov

class MovieDetailsViewOutputMock: MovieDetailsViewOutput {
    var calls = Set<Methods>()
    
    var receivedViewModel: MovieDetailsViewModel!
    
    func displayDetails(of movie: MovieDetailsViewModel) {
        self.calls.insert(.displayDetails)
        self.receivedViewModel = movie
    }
}

extension MovieDetailsViewOutputMock: Spy {
    typealias MockMethod = Methods
    
    enum Methods {
        case displayDetails
    }
    
}

