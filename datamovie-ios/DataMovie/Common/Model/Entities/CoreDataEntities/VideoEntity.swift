//
//  VideoEntity.swift
//  DataMovie
//
//  Created by Andre on 04/09/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation
import CoreData

@objc(VideoEntity)
public class VideoEntity: NSManagedObject, FetchableProtocol {
    
    @NSManaged public var key: String
    @NSManaged public var name: String
    @NSManaged public var site: String
    @NSManaged public var type: String?
    @NSManaged public var videoID: String?
    
}

// MARK: - Custom init -

extension VideoEntity {
    
    convenience init?(with model: VideoModel) {
        
        guard
            let key = model.key,
            let name = model.name,
            let site = model.site,
            site == VideoType.youtube.rawValue
        else {
            return nil
        }
        
        self.init()
        
        self.key = key
        self.name = name
        self.site = site
        self.type = model.type
        self.videoID = model.videoID
        
    }
    
    convenience private init() {
        self.init(context: CoreDataStack.sharedInstance.persistentContainer.viewContext)
    }
    
}
