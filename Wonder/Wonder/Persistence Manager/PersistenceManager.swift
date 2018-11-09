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


    // MARK: - File Existence
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
    public func addFile(id: String, data: NSData) -> (absolutePath: String?, error: NSError?) {
        
        let pathFileName = self.self.pathComposer(id: id)

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

    public func getFile(id: String) -> NSData {
        let pathFileName = self.self.pathComposer(id: id)
        return FileManager.default.contents(atPath: pathFileName)! as NSData
    }
    
    
    public func getFileAttributes(_ id: String) -> NSDictionary {
        
        // path composer
        let pathFileName = self.self.pathComposer(id: id)
        
        // File System
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: pathFileName)
            return attributes as NSDictionary
        }
        catch let error as NSError {
            print("👎 error getFileAttributes: \(error) ❌")
        }
        return NSDictionary()
    }
    
    public func getFilesNames() -> [String] {
        
        // path composer
        let path = self.getDocumentsFolder()
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: path)
            return files
        } catch {
            print("👎 error deletinf files at: \(path) ❌ error: \(error)")
        }
        return [String]()
    }

    public func deleteFile(_ id: String) -> Bool? {
        
        // path composer
        let pathFileName = self.self.pathComposer(id: id)
        
        // delete file
        do {
            try FileManager.default.removeItem(atPath: pathFileName)
        } catch {
            print("👎 error delete file: \(pathFileName) ❌ error: \(error)")
            return false
        }
        return true
        
    }
    
    @discardableResult public func deleteFileAtPath(_ pathFileName: String) -> Bool {
        
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: pathFileName)
        } catch {
            print("👎 error delete file at path: \(pathFileName) ❌ error: \(error)")
            return false
        }
        
        return true
    }
    
    @discardableResult public func deleteAllFilesAtPath(_ pathFileName: String) -> Bool {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: pathFileName)
            for file in files {
                do {
                    try FileManager.default.removeItem(atPath: "\(pathFileName)/\(file)")
                } catch {
                    print("👎 error delete file at path: \(pathFileName) ❌ error: \(error)")
                }
            }
        } catch {
            print("👎 error delete file at path: \(pathFileName) ❌ error: \(error)")
        }
        return true
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
    
    private func pathComposer(id: String) -> String {
        let fileName = "WonderFile_\(id)" + ".wdf"
        let pathFileName = self.getDocumentsFolder() + fileName
        return pathFileName
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
