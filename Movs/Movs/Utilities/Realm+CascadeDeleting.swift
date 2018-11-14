//
//  Realm+CascadeDeleting.swift
//  Movs
//
//  Created by Erick Lozano Borges on 13/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//


import RealmSwift
import Realm

protocol CascadeDeleting: class {
    func delete<S: Sequence>(_ objects: S, cascading: Bool) where S.Iterator.Element: Object
    func delete<Entity: Object>(_ entity: Entity, cascading: Bool)
}

extension Realm: CascadeDeleting {
    func delete<S: Sequence>(_ objects: S, cascading: Bool) where S.Iterator.Element: Object {
        for obj in objects {
            delete(obj, cascading: cascading)
        }
    }
    
    func delete<Entity: Object>(_ entity: Entity, cascading: Bool) {
        if cascading {
            cascadeDelete(entity)
        } else {
            delete(entity)
        }
    }
}

private extension Realm {
    private func cascadeDelete(_ entity: RLMObjectBase) {
        guard let entity = entity as? Object, !entity.isInvalidated else { return }
        var toBeDeleted = Set<RLMObjectBase>()
        toBeDeleted.insert(entity)
        while !toBeDeleted.isEmpty {
            guard let element = toBeDeleted.removeFirst() as? Object,
                !element.isInvalidated else { continue }
            resolve(element: element, toBeDeleted: &toBeDeleted)
        }
    }
    
    private func resolve(element: Object, toBeDeleted: inout Set<RLMObjectBase>) {
        element.objectSchema.properties.forEach {
            guard let value = element.value(forKey: $0.name) else { return }
            if let entity = value as? RLMObjectBase, !entity.isInvalidated {
                toBeDeleted.insert(entity)
            } else if let list = value as? RealmSwift.ListBase {
                for index in 0..<list._rlmArray.count {
                    if let realmObject = list._rlmArray.object(at: index) as? RLMObjectBase, !realmObject.isInvalidated {
                        toBeDeleted.insert(realmObject)
                    }
                }
            }
        }
        delete(element)
    }
}
