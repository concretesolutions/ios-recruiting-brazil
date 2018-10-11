//
//  DiscoverMovieItemModel.swift
//  DataMovie
//
//  Created by Andre on 26/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

protocol DiscoverItemListView {
    var title: String? { get }
    var posterPath: String? { get }
    var overview: String? { get }
    var releaseDate: String? { get }
    var buttonStatus: DMButtonStatus { get set }
}

import Foundation

struct DiscoverMovieItemModel: Decodable {
    
    //DiscoverMovieItemModel
    var buttonStatus: DMButtonStatus = .normal(nil, #imageLiteral(resourceName: "ic_plus"), true)

    var tmdbID: Int?
    var title: String?
    var posterPath: String?
    var overview: String?
    var releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case tmdbID = "id"
        case title = "title"
        case posterPath = "poster_path"
        case overview = "overview"
        case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tmdbID = try container.decodeIfPresent(Int.self, forKey: .tmdbID)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
    }

}

extension DiscoverMovieItemModel: DiscoverItemListView { }
