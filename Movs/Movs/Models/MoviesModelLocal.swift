//
//  MoviesModelLocal.swift
//  Movs
//
//  Created by Gustavo Caiafa on 19/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import Foundation
import UIKit

// Model para os filmes favoritos salvos localmente
class MoviesModelLocal {
    public var MovieLocalId : Int64?
    public var Titulo : String?
    public var Descricao : String?
    public var Data : Int?
    public var LinkFoto : String?
    public var Generos : String?
    public var MovieIdApi : Int64?
    
    init(movieid : Int64,titulo : String?,descricao : String?, data: Int?, linkfoto: String?, generos : String?, movieidapi : Int64?) {
        self.MovieLocalId = movieid
        self.Titulo = titulo
        self.Descricao = descricao
        self.Data = data
        self.LinkFoto = linkfoto
        self.Generos =  generos
        self.MovieIdApi = movieidapi
    }
    
    init(){
        
    }
    
}
