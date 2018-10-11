//
//  VideoModel.swift
//  DataMovie
//
//  Created by Andre on 02/09/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

enum VideoType: String {
    case youtube = "YouTube"
}

struct VideoModel: Decodable {
    
    var videoID: String?
    var key: String?  //O que vai na url
    var type: String? //Trailer
    var name: String?
    var site: String? //YouTube
    
    enum CodingKeys: String, CodingKey {
        case videoID    = "id"
        case key        = "key"
        case type       = "type"
        case name       = "name"
        case site       = "site"
        case results    = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        videoID = try container.decodeIfPresent(String.self, forKey: .videoID)
        key = try container.decodeIfPresent(String.self, forKey: .key)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        site = try container.decodeIfPresent(String.self, forKey: .site)
    }
    
}
