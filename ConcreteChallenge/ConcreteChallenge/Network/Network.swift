//
//  Network.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 30/10/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift


typealias Parameters = [String : Any]
typealias Completion<D> = (_ data: D?, _ err: BadRequest?) -> Void

class Network {
    
    static let manager = Network()
    
    var domain : String {
        return "https://api.themoviedb.org/3"
    }
    
    var imageDomain: String {
        return "https://image.tmdb.org/t/p/original/"
    }
    
    var apiKey: String {
        return "47265a2c299dbd2185eac909cf0dbeed"
    }
    
    private init() {}
    
    func request<Model:Decodable>(_ router: Router, parameters: Parameters? = nil, decodable: Model.Type, completion: @escaping Completion<Model>) {
        
        let url = self.domain + router.path
        
        Alamofire.request(url, method: router.method, parameters: parameters, headers: router.headers)
            .validate()
            .response { response in
                self.decodeResponse(response: response, decodable: decodable, completion: completion)
        }
    }
    
    func upload<Model:Decodable>(_ router: Router, photo: Data, parameters: [String: String]? = nil, decodable: Model.Type, completion: @escaping Completion<Model>) {
        
        let url = self.domain + router.path
        
        Alamofire.upload(multipartFormData: { form in
            
            for (key, value) in parameters ?? [:] {
                form.append(value.data(using: .utf8)!, withName: key)
            }
            form.append(photo, withName: "photo", fileName: "photo.jpeg", mimeType: "image/jpeg")
            
        }, to: url, method: router.method, headers: router.headers, encodingCompletion: { result in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.response { response in
                    
                    self.decodeResponse(response: response, decodable: decodable, completion: completion)
                }
                
            case .failure:
                
                completion(nil, BadRequest(message: "Upload failure"))
            }
        })
    }
    
    private func decodeResponse<Model:Decodable>(response: DefaultDataResponse, decodable: Model.Type, completion: @escaping Completion<Model>) {
        
        var model: Model?
        var badRequest: BadRequest?
        
        do {
            
            if let data = response.data, data.count > 0 {
                
                if response.error != nil {
                    badRequest = try JSONDecoder().decode(BadRequest.self, from: data)
                    
                } else {
                    model = try JSONDecoder().decode(decodable, from: data)
                }
            } else if let err = response.error {
                
                badRequest = BadRequest(message: err.localizedDescription)
            }
            
            completion(model, badRequest)
            
        } catch let err as NSError {
            print("internal err = ", err)
            completion(nil, BadRequest(message: "Internal error"))
        }
    }
}
