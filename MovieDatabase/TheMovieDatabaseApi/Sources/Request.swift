import Combine
import Foundation
import os.log

struct Request {
  let path: String
  let httpMethod: HTTPMethod
  let queryItems: [URLQueryItem]?

  func makeUrlRequest(baseUrl: URL) -> URLRequest {
    let url = makeUrl(baseUrl: baseUrl)
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod.rawValue
    return request
  }

  private func makeUrl(baseUrl: URL) -> URL {
    let urlString = baseUrl.appendingPathComponent(path).absoluteString
    var urlComponents = URLComponents(string: urlString)
    urlComponents?.queryItems = queryItems

    guard let url = urlComponents?.url else {
      fatalError("Failed to generate url from URLComponents")
    }

    return url
  }
}
