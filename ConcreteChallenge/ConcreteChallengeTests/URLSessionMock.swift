//
//  URLSessionMock.swift
//  ConcreteChallengeTests
//
//  Created by Matheus Oliveira Costa on 18/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import Foundation

class URLSessionMockSuccess: URLSession {

    let modelData: Data

    init(modelData: Data) {
        self.modelData = modelData
    }

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let urlResponse = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)

        completionHandler(modelData, urlResponse, nil)

        return URLSessionDataTaskMock()
    }

}

class URLSessionMockError: URLSession {

    override init() {
    }

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let nsError = NSError(domain: "", code: 0, userInfo: nil)
        completionHandler(nil, nil, nsError)
        return URLSessionDataTaskMock()
    }

}

class URLSessionMockInvalidStatusCode: URLSession {

    override init() {
    }

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let urlResponse = HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: nil, headerFields: nil)
        completionHandler(nil, urlResponse, nil)
        return URLSessionDataTaskMock()
    }

}

class URLSessionDataTaskMock: URLSessionDataTask {
    
    override init() {
    }

    override func resume() {
    }
}
