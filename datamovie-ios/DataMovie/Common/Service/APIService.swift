//
//  APIService.swift
//  DataMovie
//
//  Created by Andre on 25/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

final class APIService: NSObject {
    
    private var alamoFireManager: Alamofire.SessionManager
    private var url: String
    
    init(with url: String) {
        
        //Alamofire config
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
        alamoFireManager = Alamofire.SessionManager(configuration: config)
        
        self.url = url
        
        super.init()
    }
    
}

extension APIService {
    
    func getData<T: Decodable>(_ completion: @escaping (RequestResultType<T>) -> Void) {
        
        printRequest(url: url, method: "GET")
        
        alamoFireManager.request(url, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { response in
            self.printResponse(response: response)
            switch response.result {
            case .success:
                
                guard let data = response.data else {
                    completion(.failure(ErrorResponse("Empty data.")))
                    return
                }
                
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(ErrorResponse("Decode error: \(error.localizedDescription)")))
                }
                
            case .failure:
                completion(.failure(ErrorResponse(response: response)))
            }
        }
    }
    
}

// MARK: - Image -

extension APIService {
    
    func getImage(completionHandler: @escaping (DataResponse<Image>) -> Void) {
        debugPrint("REQUEST Download Image")
        Alamofire.request(url).validate(statusCode: 200..<300).responseImage { response in
            debugPrint("----------------------- RESPONSE ------------------------------")
            debugPrint("Request for \(response.response?.url?.absoluteString ?? "-sem url-") completed with status code \(response.response?.statusCode ?? 0)")
            completionHandler(response)
        }
    }
    
}

// MARK: - Data -

extension APIService {
    
    func downloadData(completionHandler: @escaping (DataResponse<Data>) -> Void) {
        debugPrint("REQUEST Download Data")
        Alamofire.request(url).validate(statusCode: 200..<300).responseData { response in
            debugPrint("----------------------- RESPONSE ------------------------------")
            debugPrint("Request for \(response.response?.url?.absoluteString ?? "-sem url-") completed with status code \(response.response?.statusCode ?? 0)")
            completionHandler(response)
        }
    }
    
}

extension APIService {
    
    func printRequest(url: String, method: String){
        debugPrint("----------------------- REQUEST ------------------------------")
        debugPrint("")
        debugPrint("\(method): \(url)")
        debugPrint("")
        debugPrint("---------------------------------------------------------------")
    }
    
    func printResponse(response:DataResponse<Any>){
        debugPrint("----------------------- RESPONSE ------------------------------")
        debugPrint("")
        debugPrint("Request for \(response.response?.url?.absoluteString ?? "-sem url-") completed with status code \(response.response?.statusCode ?? 0)")
        debugPrint("data:")
        if let json = response.result.value as? [String : Any] {
            print(json)
        }
        debugPrint("")
        debugPrint("---------------------------------------------------------------")
    }
    
}
