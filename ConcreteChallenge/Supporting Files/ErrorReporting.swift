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

struct ErrorReporting {
    static func start() {
        SentrySDK.start(options: [
            "dsn": Environment.Sentry.dsn,
            "release": Environment.Sentry.release,
            "environment": Environment.Sentry.environment,
            "dist": Environment.Sentry.dist,
            "debug": Environment.Sentry.debug
        ])
    }

    @discardableResult
    static func capture(_ error: Error, including scope: Scope?, notifying notificationConfig: NotificationBannerConfig?) -> String? {
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
