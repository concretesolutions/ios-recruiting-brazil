//
//  ResponseGenre.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 24/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class ResponseGenre: Decodable {
    //MARK:- Descodable Keys
    enum CodingKeysGenresResponse: String, CodingKey {
        case genres
    }
    
    //MARK: - Variables
    var genres: [Gener]?
    
    //MARK: - Init
    public init(){
    }
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeysGenresResponse.self)
        self.genres = try container.decodeIfPresent([Gener].self, forKey: .genres)
    }
}
