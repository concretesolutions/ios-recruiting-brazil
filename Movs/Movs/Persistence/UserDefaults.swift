//
//  MovieDAO.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 01/11/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import Foundation

typealias Ids = [Int]
class DefaultsMovie {
  private var userSessionKey = "com.save.usersession.favorites.movie"
  public static let shared = DefaultsMovie()
  private var standard = UserDefaults.standard
  private var ids = [Int]()
  
  private func saveids() {
    standard.set(ids, forKey: userSessionKey)
  }
  
  func saveMoveId(_ id: Int) {
    createUserDefault()
    ids.append(id)
    saveids()
  }
  
  func deleteId(_ id: Int) {
    createUserDefault()
    ids.removeAll { (idAux) -> Bool in
      if idAux == id {
        return true
      }
      return false
    }
    saveids()
  }
  
  func getAll() -> [Int] {
    createUserDefault()
    var ids = standard.value(forKey: userSessionKey) as! Ids
    ids.removeAll { (aux) -> Bool in
      if aux == 0 {
        return true
      }
      return false
    }
    return ids
  }
  
  func contains(id: Int) -> Bool {
    
    createUserDefault()
    return ids.contains(id)
  }
  
  private func createUserDefault() {
    
    if UserDefaults.standard.value(forKey: userSessionKey) == nil {
      standard.set(Ids(), forKey: userSessionKey)
    }
    ids = standard.value(forKey: userSessionKey) as! Ids
    
  }
}
