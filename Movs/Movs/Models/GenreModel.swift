//
//  GenreModel.swift
//  Movs
//
//  Created by Gustavo Caiafa on 20/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import Foundation
import ObjectMapper

// Model para os genres contidos em GenreResultModel
public class GenreModel: Mappable{
    public var GenreId : Int? = 0
    public var Name : String?
    
    required public init?(map: Map) {
    }
    
    init() {
    }
    
    public func mapping(map: Map) {
        GenreId <- map["id"]
        Name <- map["name"]
    }
    
}
