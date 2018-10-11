//
//  PersonDetailModel.swift
//  DataMovie
//
//  Created by Andre Souza on 14/09/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation
import UIKit

struct PersonDetailModel: PersonModel {
    
    var birthday: String?
    var personID: Int?
    var name: String?
    var biography: String?
    var profilePicture: String?
    var homepage: String?
    var externalIds: ExternalIDModel?
    var creditID: String?
    var gender: Int?
    
    var cachePicture: UIImage?
    var profileBgImage: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case birthday         = "birthday"
        case personID         = "id"
        case name             = "name"
        case biography        = "biography"
        case profilePicture   = "profile_path"
        case homepage         = "homepage"
        case externalIds      = "external_ids"
        case creditID         = "credit_id"
        case gender           = "gender"
    }
    
    init(personID: Int, name: String?, profileBgImage: UIImage?, cachePicture: UIImage?) {
        self.personID = personID
        self.name = name
        self.profileBgImage = profileBgImage
        self.cachePicture = cachePicture
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        birthday = try container.decodeIfPresent(String.self, forKey: .birthday)
        personID = try container.decodeIfPresent(Int.self, forKey: .personID)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        biography = try container.decodeIfPresent(String.self, forKey: .biography)
        profilePicture = try container.decodeIfPresent(String.self, forKey: .profilePicture)
        homepage = try container.decodeIfPresent(String.self, forKey: .homepage)
        externalIds = try container.decodeIfPresent(ExternalIDModel.self, forKey: .externalIds)
        gender = try container.decodeIfPresent(Int.self, forKey: .gender)
        creditID = try container.decodeIfPresent(String.self, forKey: .creditID)
    }
    
}

// MARK: Custom type

extension PersonDetailModel {
    
    var genderType: GenderType {
        get {
            if let gender = gender, let mGender = GenderType(rawValue: gender) {
                return mGender
            }
            return .none
        }
    }
    
}


extension PersonDetailModel: PersonDetailView {
    
    var birthdateFormatted: String? {
        if let birthday = self.birthday, !birthday.isEmpty,
            let date = Date(dateString: birthday) {
           return date.stringFormat()
        } else {
            return nil
        }
    }
    
}
