//
//  CrewModel.swift
//  DataMovie
//
//  Created by Andre Souza on 29/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

struct CrewModel: PersonModel {
    
    var creditID: String?
    var personID: Int?
    var gender: Int?
    var name: String?
    var profilePicture: String?
    var department: String?
    
    enum CodingKeys: String, CodingKey {
        case creditID         = "credit_id"
        case personID         = "id"
        case gender           = "gender"
        case name             = "name"
        case profilePicture   = "profile_path"
        case department       = "department"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        creditID = try container.decodeIfPresent(String.self, forKey: .creditID)
        personID = try container.decodeIfPresent(Int.self, forKey: .personID)
        gender = try container.decodeIfPresent(Int.self, forKey: .gender)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        profilePicture = try container.decodeIfPresent(String.self, forKey: .profilePicture)
        department = try container.decodeIfPresent(String.self, forKey: .department)
    }

}
