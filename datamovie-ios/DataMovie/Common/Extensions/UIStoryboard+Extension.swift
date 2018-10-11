//
//  UIStoryboard+Extension.swift
//  DataMovie
//
//  Created by Andre on 02/05/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation
import UIKit

enum StoryboardType: String {
    
    case home           = "Home"
    case addMovies      = "AddMovies"
    case listMovies     = "ListMovies"
    case movieDetail    = "MovieDetail"
    case search         = "SearchMovies"
    case discover       = "DiscoverMovies"
    case zoom           = "ZoomImage"
    case personDetail   = "PersonDetail"
    
    var name: String {
        return rawValue
    }
    
}

extension UIStoryboard {
    
    convenience init(type storyboardType: StoryboardType, bundle: Bundle? = nil) {
        self.init(name: storyboardType.name, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T {
        guard let viewController = instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.identifier) ")
        }
        return viewController
    }
    
}
