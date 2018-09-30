//
//  RLMGenderModel.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import RealmSwift

class RLMGenderModel: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
}
