//
//  FilterFavoriteWireframeMock.swift
//  MovsTests
//
//  Created by Bruno Chagas on 06/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import UIKit

@testable import Movs

class FilterFavoriteWireframeMock: FilterFavoriteWireframe {
    
    var hasCalledPresentFavoriteMovies: Bool = false
    static var hasCalledAssembleModule: Bool = false
    
    var viewController: UIViewController?
    
    func presentFilteredFavoriteMovies(filteredMovies: [MovieEntity]) {
        hasCalledPresentFavoriteMovies = true
    }
    
    static func assembleModule(movies: [MovieEntity]) -> UIViewController {
        hasCalledAssembleModule = true
        return UIViewController()
    }
    

}
