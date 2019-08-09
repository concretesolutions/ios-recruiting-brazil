//
//  ReleaseDateList.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

struct ReleaseDateList {
    var id:Int
    var resultsRelease:[ReleaseDateListItens]
    
    init(id:Int, resultsRelease:[ReleaseDateListItens]) {
        self.id = id
        self.resultsRelease = resultsRelease
    }
}

extension ReleaseDateList : Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case resultsRelease = "results"
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let codeDecodable = try container.decode(Int.self, forKey: .id)
        let resultsReleaseDecodable = try container.decode([ReleaseDateListItens].self, forKey: .resultsRelease)
        
        self.init(id:codeDecodable, resultsRelease: resultsReleaseDecodable)
    }
}

