//
//  RealmManager.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 31/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import RealmSwift

final class RealmManager {
    private static let realmConfiguration = Realm.Configuration(schemaVersion: 0, deleteRealmIfMigrationNeeded: true)

    // MARK: - Static functions

    static func realmInstance() throws -> Realm {
        return try Realm(configuration: realmConfiguration)
    }
}
