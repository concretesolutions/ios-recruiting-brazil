//
//  TMDBServiceError.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import Foundation

enum TMDBServiceError: Error {
    case buildURL(String)
    case unwrapData(String)
    case jsonParse(String,Error)
    case invalidQuery
}
