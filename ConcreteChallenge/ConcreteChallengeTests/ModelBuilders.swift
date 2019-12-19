//
//  ModelBuilders.swift
//  ConcreteChallengeTests
//
//  Created by Matheus Oliveira Costa on 18/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import Foundation

func simpleModelResponse() -> Data {
    let jsonString = """
        { "name": "Matheus" }
    """

    return jsonString.data(using: .utf8)!
}

func popularMoviesResponse() -> Data {
    let jsonString = """
        {
            "page": 1,
            "total_results": 10000,
            "total_pages": 500,
            "results": [
                {
                  "popularity": 443.655,
                  "vote_count": 1306,
                  "video": false,
                  "poster_path": "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg",
                  "id": 419704,
                  "adult": false,
                  "backdrop_path": "/5BwqwxMEjeFtdknRV792Svo0K1v.jpg",
                  "original_language": "en",
                  "original_title": "Ad Astra",
                  "genre_ids": [
                    12,
                    18,
                    9648,
                    878,
                    53
                  ],
                  "title": "Ad Astra",
                  "vote_average": 6.1,
                  "overview": "The near future, a time when both hope and hardships drive
                    humanity to look to the stars and beyond. While a mysterious phenomenon menaces
                    to destroy life on planet Earth, astronaut Roy McBride undertakes a mission across the immensity of
                    space and its many perils to uncover the truth about a lost expedition that decades before boldly
                    faced emptiness and silence in search of the unknown.",
                  "release_date": "2019-09-17"
                }
            ]
        }
    """

    return jsonString.data(using: .utf8)!
}
