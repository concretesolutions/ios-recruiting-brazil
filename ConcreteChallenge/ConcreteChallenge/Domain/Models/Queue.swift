//
//  Queue.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class Queue<Element: Equatable> {
    private var list: [Element] = []
    var elementWasRemovedCompletion: ((Element) -> Void)?
    
    var limit: Int

    var count: Int {
        return list.count
    }

    convenience init(elements: [Element], andLimit limit: Int) {
        self.init(withLimit: limit)
        elements.forEach { (element) in
            add(element)
        }
    }
    
    init(withLimit limit: Int) {
        self.limit = limit
    }

    func add(_ newElement: Element) {
        if list.count == limit {
            elementWasRemovedCompletion?(list.remove(at: 0))
        }

        list.append(newElement)
    }

    func add(array: [Element]) {
        if array.count + list.count <= limit {
            list.append(contentsOf: array)
        }
    }

    func contains(_ element: Element) -> Bool {
        return self.list.contains(element)
    }

    subscript(index: Int) -> Element {
        get {
            return list[index]
        } set {
            list[index] = newValue
        }
    }

    var array: [Element] {
        return list
    }
}
