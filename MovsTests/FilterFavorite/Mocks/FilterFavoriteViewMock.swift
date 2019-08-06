//
//  FilterFavoriteViewMock.swift
//  MovsTests
//
//  Created by Bruno Chagas on 06/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import UIKit

@testable import Movs

class FilterFavoriteViewMock: FilterFavoriteView {
    
    var hasCalledShowAvailableFilters: Bool = false
    var hasCalledAdjustContraints: Bool = false
    
    var presenter: FilterFavoritePresentation!
    
    func showAvaliableFilters(movies: [MovieEntity]) {
        hasCalledShowAvailableFilters = true
    }
    
    func adjustConstraints() {
        hasCalledAdjustContraints = true
    }
    
}
