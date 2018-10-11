//
//  CastModel.swift
//  DataMovie
//
//  Created by Andre Souza on 29/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

struct CastModel: PersonModel {
    
    var creditID: String?
    var personID: Int?
    var gender: Int?
    var castID: Int?
    var name: String?
    var profilePicture: String?
    var character: String?
    var order: Int?
    
    enum CodingKeys: String, CodingKey {
        case creditID         = "credit_id"
        case personID         = "id"
        case gender           = "gender"
        case castID           = "cast_id"
        case name             = "name"
        case profilePicture   = "profile_path"
        case character        = "character"
        case order            = "order"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        creditID = try container.decodeIfPresent(String.self, forKey: .creditID)
        personID = try container.decodeIfPresent(Int.self, forKey: .personID)
        gender = try container.decodeIfPresent(Int.self, forKey: .gender)
        castID = try container.decodeIfPresent(Int.self, forKey: .castID)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        profilePicture = try container.decodeIfPresent(String.self, forKey: .profilePicture)
        character = try container.decodeIfPresent(String.self, forKey: .character)
        order = try container.decodeIfPresent(Int.self, forKey: .order)
    }
    
}
