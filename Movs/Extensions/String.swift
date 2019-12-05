//
//  String.swift
//  Movs
//
//  Created by Gabriel D'Luca on 04/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

extension String {
    init(date: Date, components: Set<Calendar.Component>) {
        let dateComponents = Calendar.current.dateComponents(components, from: date)
        self = String(dateComponents.year!)
    }
}
