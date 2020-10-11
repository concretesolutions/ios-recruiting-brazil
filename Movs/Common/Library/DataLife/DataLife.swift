//
//  DataLife.swift
//  Movs
//
//  Created by Joao Lucas on 11/10/20.
//

import Foundation

class DataLife<T> {

    typealias CompletionHandler = ((T) -> Void)

    var value : T? {
        didSet {
            self.notifyObservers(self.observers)
        }
    }

    var observers : [Int : CompletionHandler] = [:]

    init() {}

    func observer(_ observer: ObserverProtocol, completion: @escaping CompletionHandler) {
        self.observers[observer.id] = completion
    }
    
    func notifyObservers(_ observers: [Int : CompletionHandler]) {
        if value != nil {
            observers.forEach({ $0.value(value!) })
        }
    }

    deinit {
        observers.removeAll()
    }
}
