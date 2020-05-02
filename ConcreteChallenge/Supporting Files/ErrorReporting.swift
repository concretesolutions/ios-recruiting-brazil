//
//  ErrorReporting.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 02/05/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import Foundation
import Sentry
import NotificationBannerSwift

struct NotificationBannerConfig {
    let title: String
    let subtitle: String?
    let style: BannerStyle = .info
}

class ErrorReporting {
    
    static let shared: ErrorReporting = ErrorReporting()
    
    init() {
        SentrySDK.start(options: [
            "dsn": "https://7bc447f62aeb4bfbac50495b56bc84ff@o386780.ingest.sentry.io/5221397",
            "debug": true // Enabled debug when first installing is always helpful
        ])
    }
    
    @discardableResult
    func reportError(with error: Error, including scope: Scope?, notifying notificationConfig: NotificationBannerConfig?) -> String? {
        if let notificationConfig = notificationConfig {
            DispatchQueue.main.async {
                GrowingNotificationBanner(
                    title: notificationConfig.title,
                    subtitle: notificationConfig.subtitle,
                    style: .danger
                ).show()
            }
        }
        return SentrySDK.capture(error: error, scope: scope)
    }
    
}
