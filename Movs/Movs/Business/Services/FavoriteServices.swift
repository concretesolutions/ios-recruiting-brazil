//
//  FavoriteServices.swift
//  Movs
//
//  Created by Adann Simões on 17/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import Foundation

class FavoriteServices {
    
    /// Function responsible for creating a favorite movie
    /// - parameters:
    ///     - favorite: favorite to be saved
    ///     - completion: closure to be executed at the end of this method
    /// - throws: if an error occurs during saving an object into database (Errors.DatabaseFailure)
    static func createFavorite(favorite: Favorite, _ completion: ((_ favorite: Favorite, _ error: Error?) -> Void)?) {
        
        // block to be executed in background
        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            // error to be returned in case of failure
            var raisedError: Error?
            
            do {
                // save information
                try FavoriteDAO.create(favorite)
                
            } catch let error {
                raisedError = error
            }
            
            // completion block execution
            if completion != nil {
                
                let blockForExecutionInMain: BlockOperation = BlockOperation(block: {completion!(favorite,
                                                                                                 raisedError)})
                
                // execute block in main
                QueueManager.sharedInstance.executeBlock(blockForExecutionInMain,
                                                         queueType: QueueManager.QueueType.main)
                
            }
            
        })
        
        // execute block in background
        QueueManager.sharedInstance.executeBlock(blockForExecutionInBackground,
                                                 queueType: QueueManager.QueueType.serial)
        
    }
    
    /// Function responsible for getting all favorite
    /// - parameters:
    ///     - completion: closure to be executed at the end of this method
    /// - throws: if an error occurs during getting an object from database (Errors.DatabaseFailure)
    static func getAllFavorite(_ completion: ((_ error: Error?, _ favorite: [Favorite]?) -> Void)?) {
        // block to be executed in background
        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            // error to be returned in case of failure
            var raisedError: Error?
            var favorite: [Favorite]?
            
            do {
                // save information
                favorite = try FavoriteDAO.findAll()
                
            } catch let error {
                raisedError = error
            }
            
            // completion block execution
            if completion != nil {
                
                let blockForExecutionInMain: BlockOperation = BlockOperation(block: {completion!(raisedError,
                                                                                                 favorite)})
                
                // execute block in main
                QueueManager.sharedInstance.executeBlock(blockForExecutionInMain,
                                                         queueType: QueueManager.QueueType.main)
                
            }
            
        })
        
        // execute block in background
        QueueManager.sharedInstance.executeBlock(blockForExecutionInBackground,
                                                 queueType: QueueManager.QueueType.serial)
    }
    
    
    /// Function responsible for updating a favorite
    /// - parameters:
    ///     - favorite: favorite to be updated
    ///     - completion: closure to be executed at the end of this method
    /// - throws: if an error occurs during saving an object into database (Errors.DatabaseFailure)
    static func updateFavorite(favorite: Favorite, _ completion: ((_ favorite: Favorite, _ error: Error?) -> Void)?) {
        // block to be executed in background
        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            // error to be returned in case of failure
            var raisedError: Error?
            
            do {
                // save information
                try FavoriteDAO.update(favorite)
            } catch let error {
                raisedError = error
            }
            
            // completion block execution
            if completion != nil {
                
                let blockForExecutionInMain: BlockOperation = BlockOperation(block: {completion!(favorite,
                                                                                                 raisedError)})
                
                // execute block in main
                QueueManager.sharedInstance.executeBlock(blockForExecutionInMain,
                                                         queueType: QueueManager.QueueType.main)
                
            }
            
        })
        
        // execute block in background
        QueueManager.sharedInstance.executeBlock(blockForExecutionInBackground,
                                                 queueType: QueueManager.QueueType.serial)
        
    }
    

    /// Function responsible for delete a favorite movie
    /// - parameters:
    ///     - favorite: favorite to be saved
    ///     - completion: closure to be executed at the end of this method
    /// - throws: if an error occurs during saving an object into database (Errors.DatabaseFailure)
    static func deleteFavorite(favorite: Favorite, _ completion: ((_ favorite: Favorite, _ error: Error?) -> Void)?) {
        
        // block to be executed in background
        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            // error to be returned in case of failure
            var raisedError: Error?
            
            do {
                // save information
                try FavoriteDAO.delete(favorite)
                
            } catch let error {
                raisedError = error
            }
            
            // completion block execution
            if completion != nil {
                
                let blockForExecutionInMain: BlockOperation = BlockOperation(block: {completion!(favorite,
                                                                                                 raisedError)})
                
                // execute block in main
                QueueManager.sharedInstance.executeBlock(blockForExecutionInMain,
                                                         queueType: QueueManager.QueueType.main)
                
            }
            
        })
        
        // execute block in background
        QueueManager.sharedInstance.executeBlock(blockForExecutionInBackground,
                                                 queueType: QueueManager.QueueType.serial)
        
    }
    
}
