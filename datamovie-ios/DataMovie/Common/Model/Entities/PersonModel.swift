//
//  PersonModel.swift
//  DataMovie
//
//  Created by Andre Souza on 29/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

protocol PersonModel: Decodable {
    
    var creditID: String? { get set }
    var personID: Int? { get set }
    var gender: Int? { get set }
    var name: String? { get set }
    var profilePicture: String? { get set }
    
}
