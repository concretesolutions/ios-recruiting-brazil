//
//  DataLifeProtocol.swift
//  Movs
//
//  Created by Joao Lucas on 11/10/20.
//

import Foundation

protocol DataLifeProtocol : class {
    var observers : [DataLifeProtocol] { get set }

    func observer(_ observer: ObserverProtocol)
    func notifyObservers(_ observers: [ObserverProtocol])
}
