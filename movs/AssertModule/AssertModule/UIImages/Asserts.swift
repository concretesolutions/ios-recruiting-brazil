//
//  Asserts.swift
//  AssertModule
//
//  Created by Marcos Felipe Souza on 02/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit

public struct Assets {
    public static var bundleFramework: Bundle { return Bundle(identifier: "br.com.mfelipesp.AssertModule")! }
}

//MARK: -TabBar-
public extension Assets {
    struct TabBarItems {
        
        public static let movies = UIImage(named: "list_icon",
                                           in: Assets.bundleFramework,
                                           compatibleWith: nil)
        
        public static let favoriteEmpty = UIImage(named: "favorite_empty_icon",
                                           in: Assets.bundleFramework,
                                           compatibleWith: nil)
    }
}

//MARK: -Images-
public extension Assets {
    struct Images {
        public static let searchIcon = UIImage(named: "search_icon",
                                               in: Assets.bundleFramework,
                                               compatibleWith: nil)
    }
}
