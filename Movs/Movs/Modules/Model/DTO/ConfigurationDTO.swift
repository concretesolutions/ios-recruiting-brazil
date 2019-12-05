//
//  ConfigurationDTO.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 02/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

struct ConfigurationWrapperDTO: Decodable {
    let images: ImageConfigurationDTO
}

struct ImageConfigurationDTO: Decodable {
    let baseURL: String
    let posterSizes: [String]

    private enum CodingKeys: String, CodingKey {
        case baseURL = "secure_base_url", posterSizes = "poster_sizes"
    }
}
