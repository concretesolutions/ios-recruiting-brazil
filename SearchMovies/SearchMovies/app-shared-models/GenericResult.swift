//
//  GenericResult.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

struct GenericResult {
    
    enum typeReturn:Int {
        case success = 1
        case warning = 2
        case error = 3
    }
    
    var objectReturn:AnyObject?
    var messageReturn:String?
    var typeReturnService:typeReturn
    
    init(objectReturn:AnyObject?, messageReturn:String?, typeReturnService:typeReturn) {
        self.objectReturn = objectReturn
        self.messageReturn = messageReturn
        self.typeReturnService = typeReturnService
    }
}
