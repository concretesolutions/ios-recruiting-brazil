//
//  Environment.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 17/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import Foundation
import RxSwift

enum Environment {    
    fileprivate static let infoDictionary: [String: Any] = {
      guard let dict = Bundle.main.infoDictionary else {
        fatalError("Plist file not found")
      }
      return dict
    }()
    

    static let name: String = {
      return Environment.infoDictionary["APP_ENVIRONMENT"] as! String
    }()

    // MARK: - MovieDBApi
    enum MovieDBApi {

        private static let settings = Environment.infoDictionary["MovieDBApiSettings"] as! [String: Any]

        static let baseUrl: String = {
            return MovieDBApi.settings["BaseUrl"] as! String
        }()

        static let apiKey: String = {
            return MovieDBApi.settings["ApiKey"] as! String
        }()

        static let imageBaseUrl: String = {
          return MovieDBApi.settings["ImageBaseUrl"] as! String
        }()

        static let searchDebounceTime: RxTimeInterval = .milliseconds(300)

        static let localSearchDebounceTime: RxTimeInterval = .milliseconds(200)
    }

    // MARK: - Sentry
    enum Sentry {
        private static let settings = Environment.infoDictionary["SentrySettings"] as! [String: Any]

        static let dsn: String = {
          return Sentry.settings["dsn"] as! String
        }()

        static let dist: String = {
          return Environment.infoDictionary["CFBundleVersion"] as! String
        }()

        static let release: String = {
            return Environment.infoDictionary["CFBundleShortVersionString"] as! String
        }()

        static let environment: String = {
            return Environment.name
        }()

        static let debug: Bool = {
            #if DEBUG
            return true
            #else
            return false
            #endif
        }()
    }
}
