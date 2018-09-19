//
//  LocalPersistanceWorker.swift
//  Movs
//
//  Created by Lucas Ferraço on 19/09/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import Foundation

class LocalPersistanceWorker {
	
	fileprivate let userDefaults = UserDefaults()
	
	func save<T>(_ dataToSave: T, for key: String) -> Bool where T : Encodable {
		let encoder = JSONEncoder()
		do {
			let encodedData = try encoder.encode(dataToSave)
			
			userDefaults.set(encodedData, forKey: key)
			userDefaults.synchronize()
			return true
		} catch {
			return false
		}
	}
	
	func saveToArray<T>(_ data: T, withKey key: String) -> Bool where T : Codable {
		var dataToSave = [data]
		var savedArray = fetch(dataForKey: key, ofType: [T].self)
		if let unwrappedSavedFavs = savedArray, !unwrappedSavedFavs.isEmpty {
			savedArray?.append(data)
			dataToSave = savedArray!
		}
		
		return save(dataToSave, for: key)
	}
	
	func removeFromArray<T>(_ obj: T, withKey key: String) -> Bool where T : Codable & Equatable {
		var savedArray = fetch(dataForKey: key, ofType: [T].self)
		if let index = savedArray?.index(of: obj) {
			savedArray?.remove(at: index)
		}
		
		return save(savedArray, for: key)
	}
	
	func fetch<T>(dataForKey key: String, ofType: T.Type) -> T? where T : Decodable {
		guard let data = userDefaults.data(forKey: key) else { return nil }
		
		let decoder = JSONDecoder()
		do {
			let decodedData = try decoder.decode(T.self, from: data)
			return decodedData
		} catch {
			return nil
		}
	}
}
