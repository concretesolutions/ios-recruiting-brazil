//
//  MockSession.swift
//  ios-recruiting-brazilTests
//
//  Created by Adriel Freire on 12/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import Foundation
@testable import ios_recruiting_brazil
class MockURLSession: URLSessionProtocol {

    var nextDataTask = MockURLSessionDataTask()
    lazy var response: HTTPURLResponse = createResponse(statusCode: 200)
    func dataTask(with url: URLRequest, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTaskProtocol {
        result(.success((response, loadJson(withTitle: "Result"))))
        return nextDataTask
    }
    
//    private (set) var lastURL: URL?

    private func loadJson(withTitle title: String) -> Data {
        var data = Data()
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: title, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        return data
    }
    
    func createResponse(statusCode: Int) -> HTTPURLResponse {
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
        return response
    }
}

