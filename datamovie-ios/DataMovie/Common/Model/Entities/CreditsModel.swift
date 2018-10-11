//
//  CreditsModel.swift
//  DataMovie
//
//  Created by Andre Souza on 29/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

struct CreditsModel: Decodable {
    
    var cast: [CastModel]?
    //var crew: [CrewModel]?
    
    enum CodingKeys: String, CodingKey {
        case cast = "cast"
        //case crew = "crew"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cast = try container.decodeIfPresent([CastModel].self, forKey: .cast)
        //crew = try container.decodeIfPresent([CrewModel].self, forKey: .crew)
    }
    
}
