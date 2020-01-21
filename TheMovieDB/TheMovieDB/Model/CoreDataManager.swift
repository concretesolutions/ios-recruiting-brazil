//
//  CoreDataManager.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 20/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager: NSObject {
  static let shared = CoreDataManager()
  
  private override init() { }
  
  func foregroundOperation(completion: @escaping (NSManagedObjectContext?) -> Void) {
    DispatchQueue.main.async {
      let delegate = UIApplication.shared.delegate as? AppDelegate
      let managedContext = delegate?.persistentContainer.viewContext
      completion(managedContext)
    }
  }
}

