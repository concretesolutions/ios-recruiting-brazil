//
//  CancelableTask.swift
//  GenericNetwork
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

/// A type that can be cancelled.
public protocol CancellableTask {
    func cancel()
}

extension URLSessionDataTask: CancellableTask { }

extension URLSessionDownloadTask: CancellableTask { }
