//
//  ErrorViewFactory.swift
//  Movs
//
//  Created by Adrian Almeida on 28/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum ErrorViewFactory {
    static func make() -> ErrorView {
        let errorView = ErrorView()
        errorView.isHidden = true

        return errorView
    }
}
