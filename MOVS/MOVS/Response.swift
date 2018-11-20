//
//  Response.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 18/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class Response: Decodable{
    //MARK:- Descodable Keys
    enum CodingKeysResponse: String, CodingKey {
        case page
        case total_results
        case total_pages
        case results
    }
    
    //MARK: - Variables
    var page: Int?
    var total_results: Int?
    var total_pages: Int?
    var results: [ResponseFilm]?
    
    //MARK: - Init
    public init(){
    }
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeysResponse.self)
        self.page = try container.decodeIfPresent(Int.self, forKey: .page)
        self.total_results = try container.decodeIfPresent(Int.self, forKey: .total_results)
        self.total_pages = try container.decodeIfPresent(Int.self, forKey: .total_pages)
        self.results = try container.decodeIfPresent([ResponseFilm].self, forKey: .results)
    }
    
}
