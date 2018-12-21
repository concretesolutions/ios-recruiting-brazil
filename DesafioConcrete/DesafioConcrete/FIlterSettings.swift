//
//  FIlterSettings.swift
//  DesafioConcrete
//
//  Created by Ian Manor on 20/12/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation

class FilterSettings {
    static let shared = FilterSettings()
    
    private init() {}
    
    var isOn: Bool = false
    var date: String?
    var genre: Int?
}
