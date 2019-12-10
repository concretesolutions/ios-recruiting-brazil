//
//  MovieData.swift
//  RecruitingChallenge
//
//  Created by Giovane Barreira on 12/2/19.
//  Copyright © 2019 Giovane Barreira. All rights reserved.
//

import Foundation

struct MovieData: Decodable {
    let results: [Main]
}

struct Main: Decodable {
    let title: String
    let poster_path: String?
    let release_date: String
    let genre_ids: [Int]
    let overview: String
}

struct Genre: Decodable {
    let id: Int
    let name: String
}

