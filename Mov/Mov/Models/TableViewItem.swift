//
//  TableViewItem.swift
//  Mov
//
//  Created by Allan on 13/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import Foundation

struct TableViewItem {
    
    enum TableViewItemType: String {
        case cover = "CoverTableViewCell"
        case simple = "SimpleTableViewCell"
        case text = "TextTableViewCell"
    }
    
    var type: TableViewItemType
    var text: String?
    var isFavorite: Bool?
    var imageURL: String?
    var field: String?
    
    init(type: TableViewItemType, text: String?, field: String? = nil, imageURL: String? = nil,  isFavorite: Bool? = nil) {
        self.type = type
        self.text = text
        self.field = field
        self.isFavorite = isFavorite
        self.imageURL = imageURL
    }
    
    
}
