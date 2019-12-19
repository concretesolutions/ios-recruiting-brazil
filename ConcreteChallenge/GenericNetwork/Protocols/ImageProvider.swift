//
//  FileProvider.swift
//  GenericNetwork
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

public protocol FileProvider: Provider where ReturnType == URL { }
