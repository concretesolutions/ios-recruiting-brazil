//
//  Injector.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 23/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

/// It helps to inject objects when this object need some data to me initilized
typealias Injector<Injected, Data> = (Data) -> Injected
