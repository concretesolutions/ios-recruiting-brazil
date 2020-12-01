//
//  TMDBResponse.swift
//  Movs
//
//  Created by Gabriel Coutinho on 30/11/20.
//

import Foundation

protocol TMDBResponse: Codable {
    var success: Bool { get }
}
