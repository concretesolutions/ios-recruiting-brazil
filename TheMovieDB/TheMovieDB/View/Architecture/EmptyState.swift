//
//  EmptyState.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 19/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation


public enum EmptyState {
    case networkError
    case noResults
    case noData
    case loading
    case none
    
    var description: String? {
        switch self {
            case .networkError: return NSLocalizedString("Ops! occurred error. Verify your connection with internet.", comment: "Network Error")
            case .noResults: return NSLocalizedString("Not result", comment: "Not results in search")
            case .noData: return NSLocalizedString("Not registers", comment: "Not informations saved")
            case .loading: return NSLocalizedString("Loading, wait please.", comment: "Waiting download informations")
            case .none: return nil
        }
    }
    
    var imagePath: String? {
        switch self {
            case .networkError: return "network"
            case .noResults: return "results"
            case .noData: return "box"
            case .loading: return "loading"
            case .none: return nil
        }
    }
}
