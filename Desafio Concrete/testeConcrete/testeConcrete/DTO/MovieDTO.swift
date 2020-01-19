//
//  MovieDTO.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 19/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import Foundation

class MovieDTO:Codable{
    var page   :Int?
    var results:[Movie]?
}
