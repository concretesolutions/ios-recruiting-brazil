//
//  ErrorResponse.swift
//  DataMovie
//
//  Created by Andre Souza on 11/07/2018.
//  Copyright © 2018 AndreSamples. All rights reserved.
//

import Foundation
import Alamofire

protocol ErrorInterface {
    var title: String { get }
    var message: String? { get }
    var hideButton: Bool { get }
    var buttonText: String { get }
}

struct ErrorResponse: Decodable, ErrorInterface {
    
    var title: String = "Attention"
    var message: String?
    var code: Int?
    var hideButton: Bool = false
    var buttonText: String = "Retry"
    
    enum CodingKeys: String, CodingKey {
        case message = "status_message"
        case code = "status_code"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decode(String.self, forKey: .message)
        self.code = try container.decode(Int.self, forKey: .code)
    }
    
}

// MARK: - DataResponse Init -

extension ErrorResponse {
    
    init(response: DataResponse<Any>) {
        //TODO verificar para ocultar o botão
        if let data = response.data {
            do {
                self = try JSONDecoder().decode(ErrorResponse.self, from: data)
            } catch {
                message = ResponseType.UNDEFINED.message
            }
        } else {
            var errorType: ResponseType
            
            if let statusCode = response.response?.statusCode {
                errorType = ResponseType(rawValue: statusCode) ?? .UNDEFINED
            } else if let error = response.error {
                let code = (error as NSError).code
                errorType = ResponseType(rawValue: code) ?? .UNDEFINED
            } else {
                errorType = .UNDEFINED
            }
            
            title = errorType.title
            message = errorType.message
        }
    }
    
}

// MARK: - Message Init -

extension ErrorResponse {
    
    init(_ message: String) {
        self.message = message
    }
    
}

// MARK: - ResponseType Init -

extension ErrorResponse {
    
    init(_ resultType: ResponseType) {
        self.title = resultType.title
        self.message = resultType.message
        self.code = resultType.rawValue
    }
    
}
