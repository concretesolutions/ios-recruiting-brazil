//
//  Equatables+Tests.swift
//  ListMovsFeatureTests
//
//  Created by Marcos Felipe Souza on 30/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation
@testable import ListMovsFeature

extension ListMovsHandleState: Equatable {
    public static func == (lhs: ListMovsHandleState, rhs: ListMovsHandleState) -> Bool {
        switch (lhs, rhs) {
        case (.success(let value), .success(let value2)):
            return value.items.count == value2.items.count
        case (.loading(let loading), .loading(let loading2)):
            return loading == loading2
        case (.failure, .failure): return true
        case (.emptySearch, .emptySearch): return true
        case (.searching, .searching): return true
        case (.reloadData, .reloadData): return true
        case (.favoriteMovie, .favoriteMovie): return true
        case (.showDetail, .showDetail): return true
        default:
            return false
        }
    }
}


extension DetailItemHandleState: Equatable {
    public static func == (lhs: DetailItemHandleState, rhs: DetailItemHandleState) -> Bool {
        switch (lhs, rhs) {
        case (.loading(let result), .loading(let result2)):
            return result == result2
        case (.success(let item), .success(let item2)):
            return item.id == item2.id
        default:
            return false 
        }
    }
}
//case loading(Bool)
//case success(MovsItemViewData)
