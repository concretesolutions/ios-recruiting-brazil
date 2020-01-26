//
//  SearchBarDelegate.swift
//  movs
//
//  Created by Isaac Douglas on 26/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

protocol SearchBarDelegate: UISearchBarDelegate {
    associatedtype Item
    
    func completeItems() -> [Item]
    func filteredItems(items: [Item])
    func filter(text: String, item: Item) -> Bool
}
