//
//  PopularMoviesGridTartTypeMock.swift
//  ios-recruiting-brazilTests
//
//  Created by André Vieira on 01/10/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Moya

enum PopularMoviesGridTartTypeMock {
    case popularMovies
    case filterMovies
}

extension PopularMoviesGridTartTypeMock: TargetType {
    var baseURL: URL {
        return URL(string: "")!
    }
    
    var path: String {
        switch self {
        case .popularMovies:
            return "ResponsePopularMovies"
        case .filterMovies:
            return "ResponsePopularMoviesFilter"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
       return .requestPlain
    }
    
    var headers: [String: String]? {
        return nil
    }
}
