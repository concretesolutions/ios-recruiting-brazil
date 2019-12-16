//
//  URLSessionMock.swift
//  MovsTests
//
//  Created by Gabriel D'Luca on 14/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation
@testable import Movs

class URLSessionMock: Movs.NetworkSession {
    
    // MARK: - Properties
    
    var data: Data?
    var error: Error?

    func getData(from urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        completion(data, error)
    }
}
