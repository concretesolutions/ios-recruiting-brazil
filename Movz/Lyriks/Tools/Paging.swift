//
//  Paging.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 03/08/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import Foundation

protocol Paging {
    associatedtype type
    var data:type{get set}
    var pageCount:Int{get set}
    var canRefresh:Bool {get set}
    
    func addElement( model:Movie)
}
