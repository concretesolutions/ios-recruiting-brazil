//
//  RealmModel.swift
//  RecruitingChallenge
//
//  Created by Giovane Barreira on 12/9/19.
//  Copyright © 2019 Giovane Barreira. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class RealmModel: Object {
    dynamic var movieTitle: String?
    dynamic var movieDesc: String?
    dynamic var posterImage: Data?
    dynamic var year: String?
}
