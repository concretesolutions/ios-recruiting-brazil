//
//  Resource.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation
struct Resource {
    let url: URL
    var dataObject:Data?
    
    init(url:URL, dataObject:Data?) {
        self.url = url
        self.dataObject = dataObject
    }
}
