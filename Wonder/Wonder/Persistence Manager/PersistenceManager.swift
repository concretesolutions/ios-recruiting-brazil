//
//  PersistenceManager.swift
//  Wonder
//
//  Created by Marcelo on 09/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

private let sharedInstance = PersistenceManager()

class PersistenceManager {
    
    // MARK: - Instance
    class var standard: PersistenceManager {
        return sharedInstance
    }
    
    // MARK: - Helpers
    public func getApplicationFolder() -> String {
        return applicationFolder()
    }
    
    public func getDocumentsFolder() -> String {
        return documentsFolder()
    }
    
    private func applicationFolder() -> String {
        return Bundle.main.resourcePath!
    }
    
    private func documentsFolder() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }


    // MARK: - Existance Methods
    public func fileExists(name: String) -> Bool {
        // path composer
        let pathFileName = self.documentsFolder() + "/" + name
        
        // file system
        let fileManager = FileManager.default
        
        // Check if file exists, given its path
        if fileManager.fileExists(atPath: pathFileName) {
            return true
        }
        return false
    }
    
    public func fileExists(_ absolutPath: String) -> Bool {
        return FileManager.default.fileExists(atPath: absolutPath)
    }
    
    // MARK: - I/O Operations
    public func addFile(data: NSData, id: String) -> (absolutePath: String?, error: NSError?) {

        let fileName = "WonderFile_\(id)" + ".wdf"
        let pathFileName = self.getDocumentsFolder() + fileName

        if fileExists(pathFileName) {
            return(nil, self.generateError(code: 9001, message: "File already exists!"))
        }

        // save file to the disk
        do {
            let dataSize = Double(data.length) / 1024.0 / 1024.0
            if (dataSize > deviceRemainingFreeSpaceInBytes()) {
                let errorDomain = NSLocalizedString("app-domain-name", comment:"")
                let errorCode = 8000
                let errorUserInfo = [NSLocalizedDescriptionKey : NSLocalizedString("error-out-of-space", comment:"")]
                let errorObject = NSError.init(domain: errorDomain, code: errorCode, userInfo: errorUserInfo)

                return (nil, errorObject)
            }

            try data.write(toFile: pathFileName, options: .atomic)
            return(pathFileName, nil)

        } catch {
            let errorDomain = NSLocalizedString("app-domain-name", comment:"")
            let errorCode = 8000
            let errorUserInfo = [NSLocalizedDescriptionKey : NSLocalizedString("error-addFile", comment:"")]
            let errorObject = NSError.init(domain: errorDomain, code: errorCode, userInfo: errorUserInfo)

            return (nil, errorObject)
        }
    }

    
    // MARK: - I/O Helpers
    private func deviceRemainingFreeSpaceInBytes() -> Double {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        guard
            let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: documentDirectory),
            let freeSize = systemAttributes[.systemFreeSize] as? NSNumber
            else {
                return 0
        }
        return freeSize.doubleValue
    }
    
    
    
    
    
    // MARK: - Error Handler
    private func generateError(code: Int, message: String) -> NSError {
        let errorDomain = NSLocalizedString("wonder-domain", comment:"")
        let errorCode = code
        let errorUserInfo = [NSLocalizedDescriptionKey : message]
        let errorObject = NSError.init(domain: errorDomain, code: errorCode, userInfo: errorUserInfo)
        return errorObject
        
    }
    
    
    
}
