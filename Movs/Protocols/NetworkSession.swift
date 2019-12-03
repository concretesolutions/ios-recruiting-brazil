//
//  NetworkSession.swift
//  Movs
//
//  Created by Gabriel D'Luca on 03/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

protocol NetworkSession {
    func getData(from urlString: String, completion: @escaping (Data?, Error?) -> Void)
}
