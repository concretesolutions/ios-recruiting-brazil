//
//  QueueManager.swift
//  Movs
//
//  Created by Adann Simões on 17/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import Foundation
class QueueManager {
    
    // supported queues
    enum QueueType { case main, concurrent, serial }
    
    /// Queue used to serial operations
    fileprivate var serialQueue: OperationQueue?
    
    /// Queue used to concurrent operations
    fileprivate var concurrentQueue: OperationQueue?
    
    /// queue manager singleton instance
    static let sharedInstance: QueueManager = QueueManager()
    
    /// Private initializer used to create and configure internal queues
    fileprivate init() {
        // initialize & configure serial queue
        serialQueue = OperationQueue()
        serialQueue?.maxConcurrentOperationCount = 1
        
        // initialize & configure concurrent queue
        concurrentQueue = OperationQueue()
        
    }
    
    /// function responsible for executing a block of code in a particular queue
    /// - params:
    ///     - NSBlockOperation: block operation to be executed
    ///     - QueueType: queue where the operation will be executed
    func executeBlock(_ blockOperation: BlockOperation, queueType: QueueType) {
        // get queue where operation will be executed
        let queue: OperationQueue = self.getQueue(queueType)
        
        // execute operation
        queue.addOperation(blockOperation)
        
    }
    
    /// function responsible for returning a specifi queue
    /// params:
    ///     - QueueType: desired queue
    /// returns: queue in according to the given param
    func getQueue(_ queueType: QueueType) -> OperationQueue {
        // queue to be returned
        var queueToBeReturned: OperationQueue?
        
        // decide which queue
        switch queueType {
            
        case .concurrent:
            queueToBeReturned = self.concurrentQueue
            
        case .main:
            queueToBeReturned = OperationQueue.main
            
        case .serial:
            queueToBeReturned = self.serialQueue
            
        }
        
        return queueToBeReturned!
        
    }
    
}
