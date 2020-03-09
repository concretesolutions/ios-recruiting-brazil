//
//  InvalidAccessModel.swift
//  NetworkLayerModule
//
//  Created by Marcos Felipe Souza on 08/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation


// MARK: - MovsListRequest
struct InvalidAccessModel: Codable {
    let statusCode: Int
    let statusMessage: String    

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
