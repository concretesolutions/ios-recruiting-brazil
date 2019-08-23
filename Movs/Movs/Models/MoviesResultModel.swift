//
//  MoviesResultModel.swift
//  Movs
//
//  Created by Gustavo Caiafa on 16/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import Foundation
import ObjectMapper

// Model para o resultado todo da chamada GetPopularMovies
public class MoviesResultModel: Mappable{
    public var Pagina : Int? = 0
    public var Movies : [MoviesModel]?
    public var QtdePaginas : Int? = 0
    public var QtdeMovies : Int? = 0
    
    
    required public init?(map: Map) {
    }
    
    init() {
    }
    
    public func mapping(map: Map) {
        Pagina <- map["page"]
        Movies <- map["results"]
        QtdePaginas <- map["total_pages"]
        QtdeMovies <- map["total_results"]
    }
    
}
