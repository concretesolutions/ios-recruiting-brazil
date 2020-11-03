//
//  DatabaseError.swift
//  Movs
//
//  Created by Adrian Almeida on 31/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

enum DatabaseError: Error {
    case unknown
    case taskError(error: Error)
    case save
    case delete

    // MARK: - Computed variables

    var errorDescription: String {
        switch self {
        case .unknown:
            return localizedDescription
        case .taskError(let error):
            return error.localizedDescription
        case .save:
            return Strings.errorSave.localizable
        case .delete:
            return Strings.errorDelete.localizable
        }
    }
}
