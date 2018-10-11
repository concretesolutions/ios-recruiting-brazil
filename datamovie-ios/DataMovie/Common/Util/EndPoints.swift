//
//  EndPoints.swift
//  DataMovie
//
//  Created by Andre on 25/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

enum Configuration {
    
    enum ImageSize: String {
        case w200 = "w200"
        case w500 = "w500"
    }
    
    enum ItemAppend: String {
        case videos = "videos"
        case credits = "credits"
        case images = "images" //&include_image_language=en
        case externalInfos = "external_ids"
    }
    
}


enum QueryItem {
    
    case none, key, page, query, region, language, appendToResponse
    
    var key: String {
        switch self {
        case .none:
            return ""
        case .key:
            return "api_key"
        case .page:
            return "page"
        case .query:
            return "query"
        case .region:
            return "region"
        case .language:
            return "language"
        case .appendToResponse:
            return "append_to_response"
        }
    }
    
    enum DefaultValues: String {
        case us = "US"
        case english = "en-US"
    }
    
}

enum DiscoverEndpoint {
    
    case nowPlaying(Int), upComing(Int), topRated(Int)
    
    var path: String {
        switch self {
        case .nowPlaying(_):
            return "/now_playing"
        case .upComing(_):
            return "/upcoming"
        case .topRated(_):
            return "/top_rated"
        }
    }
    
    var page: Int {
        switch self {
        case .nowPlaying(let page):
            return page
        case .upComing(let page):
            return page
        case .topRated(let page):
            return page
        }
    }
    
}

enum EndPoint {
    
    case discover(DiscoverEndpoint)
    case search(String, Int)
    case detail(Int, [Configuration.ItemAppend])
    case credits(Int)
    case recommendations(Int, Int)
    case person(Int)
    
    var path: String {
        switch self {
        case .discover(let type):
            return "/movie\(type.path)"
        case .search(_, _):
            return "/search/movie"
        case .detail(let id, _):
            return "/movie/\(id)"
        case .credits(let id):
            return "/movie/\(id)/credits"
        case .recommendations(let id, _):
            return "/movie/\(id)/recommendations"
        case .person(let id):
            return "/person/\(id)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .discover(let type):
            let region = Locale.current.regionCode ?? QueryItem.DefaultValues.us.rawValue
            return [URLQueryItem(item: .page, value: "\(type.page)"), URLQueryItem(item: .region, value: region)]
        case .search(let query, let page):
             return [URLQueryItem(item: .query, value: query), URLQueryItem(item: .page, value: "\(page)")]
        case .detail(_, let items):
            return [URLQueryItem(item: .appendToResponse, value: items.compactMap({ $0.rawValue }).joined(separator: ","))]
        case .recommendations(_, let page):
            return [URLQueryItem(item: .page, value: "\(page)")]
        case .person(_):
            return [URLQueryItem(item: .appendToResponse, value: .externalInfos)]
        default: return []
        }
    }

}

enum TMDBUrl {
    
    case base, image(Configuration.ImageSize, String), video(String), videoThumb(String)
    
    var url: String {
        switch self {
        case .base:
            return "https://api.themoviedb.org/3"
        case .image(let imageSize, let posterID):
            return "https://image.tmdb.org/t/p/\(imageSize.rawValue)/\(posterID)"
        case .video(let videoKey):
            return "https://www.youtube.com/embed/\(videoKey)"
        case .videoThumb(let videoKey):
            return "https://img.youtube.com/vi/\(videoKey)/0.jpg"
        }
    }
}

final class DMUrl {
    
    fileprivate static let tmdbKey: String = "a30093354b1de83ea236c6321052d362"

    private init() { }
    
    static func url(for endPoint: EndPoint) -> String {
        var components = URLComponents(string: "\(TMDBUrl.base.url)\(endPoint.path)")!
        var baseQueryItems: [URLQueryItem] = [URLQueryItem(item: .key, value: tmdbKey),
                                              URLQueryItem(item: .language, value: .english)]
        baseQueryItems.append(contentsOf: endPoint.queryItems)
        components.queryItems = baseQueryItems
        return "\(components)"
    }
    
}
