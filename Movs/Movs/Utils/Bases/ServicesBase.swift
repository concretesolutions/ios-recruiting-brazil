//
//  ServicesBase.swift
//  Movs
//
//  Created by Marcos Lacerda on 08/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

internal class ServicesBase: NSObject {
  
  // MARK: - Commom attributes
  
  /// Define the default parameter with "api_key"
  internal var defaultParams: [String: Any] = ["api_key": SecurityManager.shared.reveal(Constants.kMovieApiKey)]
  
  /// Default decoder to use in desearization
  internal let decoder = JSONDecoder()
  
  // MARK: - Commom methods

  func parseError(_ error: Error) -> String {
    if error._code == NSURLErrorTimedOut {
      return "timeout-error".localized()
    }

    return error.localizedDescription
  }
  
  func makeURL(_ operation: APIOperations) -> URL {
    let baseURL = String(format: "%@%@", Bundle.main.kBaseURL, operation.rawValue)

    guard let url = URL(string: baseURL) else {
      fatalError("Error to handler base url to a URL")
    }

    return url
  }

}
