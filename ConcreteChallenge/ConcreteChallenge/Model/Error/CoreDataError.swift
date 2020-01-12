//
//  CoreDataError.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 20/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import Foundation

enum CoreDataError: LocalizedError {
    case modelLoad
    case cantSave
    case wrongContainer
    case wrongContext
    case wrongEntityName
    case wrongFetch
    case cantDeleteObject

    var localizedDescription: String {
        switch self {
        case .modelLoad: return "Error while loading database"
        case .cantSave: return "Error while saving"
        case .cantDeleteObject: return "Error while deleting"
        case .wrongContainer: return "Error Container Does Not Exist"
        case .wrongContext: return "Error Context Does Not Exist"
        case .wrongEntityName: return "Error Entity Name Does Not Exist"
        case .wrongFetch: return "Error During Fetch"
        }
    }

    var errorDescription: String? {
        localizedDescription
    }
}
