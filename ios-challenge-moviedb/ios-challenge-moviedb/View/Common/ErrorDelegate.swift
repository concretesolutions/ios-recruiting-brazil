//
//  ErrorDelegate.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 27/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import Foundation

protocol ErrorDelegate {
    func showError(imageName: String, text: String)
    func removeError()
}
