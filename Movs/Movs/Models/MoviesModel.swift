//
//  MoviesModel.swift
//  Movs
//
//  Created by Gustavo Caiafa on 14/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import Foundation
import ObjectMapper

// Model para o os filmes contidos no MoviesResultModel
public class MoviesModel: Mappable{
    public var Id : Int64? = 0
    public var Titulo : String? = "N/D"
    public var Descricao : String? = "N/D"
    public var Data : String? = "N/D"
    public var linkFoto : String? = ""
    public var idGenero : [Int]? = nil
    public var isFavorito : Bool = false
    
    required public init?(map: Map) {
    }
    
    init() {
    }
    
    public func mapping(map: Map) {
        Id <- map["id"]
        Titulo <- map["title"]
        Descricao <- map["overview"]
        Data <- map["release_date"]
        linkFoto <- map["poster_path"]
        idGenero <- map["genre_ids"]
    }
    
}
