//
//  Response.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 16/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class GenersResponse: Decodable {
    //MARK:- Descodable Keys
    enum CodingKeysGenres: String, CodingKey {
        case id
        case name
    }
    
    //MARK: - Variables
    var id: Int?
    var name: String?
    
    //MARK: - Init
    public init(){
    }
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeysGenres.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }
    
}
