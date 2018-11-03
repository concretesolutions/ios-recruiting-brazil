//
//  FiltersPresentationLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol FiltersPresentationLogic {
    /**
     Present the filters requested.
     
     - parameters:
         - response: Response of the filters requested.
     */
    func present(response: Filters.Response)
}
