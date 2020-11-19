import Foundation

public struct Middleware {
  public let apply: (inout URLRequest) -> Void
}

// MARK: Default/Common Middlewares

public extension Middleware {
  static func defaultHeadersMiddleware() -> Middleware {
    Middleware { request in
      request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
    }
  }

  static func authenticationMiddleware(apiKey: String) -> Middleware {
    Middleware { request in
      let bearerToken = "Bearer \(apiKey)"
      request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
    }
  }
}

// MARK: Helper

public extension Array where Element == Middleware {
  func apply(to request: inout URLRequest) {
    for middleware in self {
      middleware.apply(&request)
    }
  }
}
