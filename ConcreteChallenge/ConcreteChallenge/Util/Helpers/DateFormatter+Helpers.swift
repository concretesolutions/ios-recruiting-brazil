//
//  DateFormatter+Helpers.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 20/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//
import Foundation

extension DateFormatter {
    static let databaseDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }()

    static let databaseTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:ii:ss"
        return formatter
    }()

    static let databaseDateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:ii:ss"
        return formatter
    }()
}
