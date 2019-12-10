//
//  HTTPTask.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

public enum Task {
    case requestPlain
    case requestWithQuery([String: Any])
    case requestWithBody(Codable)
}
