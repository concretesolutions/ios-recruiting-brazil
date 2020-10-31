//
//  MovieRealmDbService.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 31/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import RealmSwift

final class MovieRealmDbService {
    func save<T: Object>(model: T, completion: @escaping (Result<Void, DatabaseError>) -> Void) where T: RealmModelProtocol {
        DispatchQueue.main.async {
            do {
                let realm = try RealmManager.realmInstance()
//                let id = try self.incrementId(model.self)
//                var model = model
//                model.id = id
                try realm.write {
                    realm.add(model)
                }
                completion(.success(()))
            } catch {
                completion(.failure(DatabaseError.taskError(error: error)))
            }
        }
    }

    func delete<T: Object>(model: T, completion: @escaping (Result<Void, DatabaseError>) -> Void) {
        DispatchQueue.main.async {
            do {
                let realm = try RealmManager.realmInstance()
                try realm.write {
                    realm.delete(model)
                }
                completion(.success(()))
            } catch {
                completion(.failure(DatabaseError.taskError(error: error)))
            }
        }
    }

    func fetch<T: Object>(_ type: T.Type, completion: @escaping (Result<[T], DatabaseError>) -> Void) {
        DispatchQueue.main.async {
            do {
                let realm = try RealmManager.realmInstance()
                let models = Array(realm.objects(T.self))
                completion(.success(models))
            } catch {
                completion(.failure(DatabaseError.taskError(error: error)))
            }
        }
    }

    func incrementId<T: Object>(_ type: T) throws -> Int where T: RealmModelProtocol {
        do {
            let realm = try RealmManager.realmInstance()
            let id = realm.objects(T.self).max(ofProperty: Constants.MovieDatabase.moviePrimaryKey) as Int? ?? 0
            return id+1
        } catch {
            throw error
        }
    }
}
