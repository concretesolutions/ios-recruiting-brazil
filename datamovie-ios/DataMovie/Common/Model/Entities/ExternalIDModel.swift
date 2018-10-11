//
//  ExternalIDModel.swift
//  DataMovie
//
//  Created by Andre Souza on 20/09/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

//{
//    "id": 1246,
//    "twitter_id": null,
//    "facebook_id": null,
//    "tvrage_id": 70148,
//    "instagram_id": null,
//    "freebase_mid": "/m/03k545",
//    "imdb_id": "nm0607865",
//    "freebase_id": "/en/emily_mortimer"
//}

import Foundation

import Foundation
import UIKit

struct ExternalIDModel: Decodable {
    
    var twitterID: String?
    var facebookID: String?
    var instagramID: String?
    var imdbID: String?
    
    enum CodingKeys: String, CodingKey {
        case twitter         = "twitter_id"
        case facebook        = "facebook_id"
        case instagram       = "instagram_id"
        case imdb            = "imdb_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let twitter = try container.decodeIfPresent(String.self, forKey: .twitter), (!twitter.isEmpty && !twitter.contains("null")) {
            twitterID = twitter
        }
        if let facebook = try container.decodeIfPresent(String.self, forKey: .facebook), (!facebook.isEmpty && !facebook.contains("null")) {
            facebookID = facebook
        }
        if let instagram = try container.decodeIfPresent(String.self, forKey: .instagram), (!instagram.isEmpty && !instagram.contains("null")) {
            instagramID = instagram
        }
        if let imdb = try container.decodeIfPresent(String.self, forKey: .imdb), (!imdb.isEmpty && !imdb.contains("null")) {
            imdbID = imdb
        }
    }

}
