//
//  APIRequestType.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 21/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

enum RequestType: String {
    case feed = "/3/movie/popular"
    case genres = "/3/genre/movie/list"
    case search = "/3/search/movie"
}
