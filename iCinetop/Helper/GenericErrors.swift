//
//  GenericErrors.swift
//  iCinetop
//
//  Created by Alcides Junior on 14/12/19.
//  Copyright © 2019 Alcides Junior. All rights reserved.
//

import Foundation
struct GenericErrors: Codable{
    let statusMessage: String
    let success: Bool?
    let statusCode: Int

    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case success
        case statusCode = "status_code"
    }
}
struct CustomError: Error {
    
    let message: String

    init(_ message: String){
        self.message = message
    }
    
    
}
