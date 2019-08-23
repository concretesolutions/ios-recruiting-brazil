//
//  GenreResultModel.swift
//  Movs
//
//  Created by Gustavo Caiafa on 20/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import Foundation
import ObjectMapper

// Model para o resultado todo da chamada GetGenres
public class GenreResultModel: Mappable{
    public var Genres : [GenreModel]?
    
    required public init?(map: Map) {
    }
    
    init() {
    }
    
    public func mapping(map: Map) {
        Genres <- map["genres"]
    }
    
}
