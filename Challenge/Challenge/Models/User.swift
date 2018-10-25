//
//  User.swift
//  Challenge
//
//  Created by Sávio Berdine on 20/10/18.
//  Copyright © 2018 Sávio Berdine. All rights reserved.
//

import Foundation
import Alamofire

class User {
    
    var username: String?
    var userId: Int?
    var sessionId: String?
    var token: String?
    
    static let user = User()
    
    func login(username: String, password: String, onSuccess: @escaping (_ sessionId: String) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        self.username = username
        if User.user.token != nil {
            self.requestToken(onSuccess: { (token) in
                self.token = token
                self.validateToken(token: token, password: password, onSuccess: { (validatedToken) in
                    self.generateSessionId(validatedToken: validatedToken, onSuccess: { (sessionId) in
                        onSuccess(sessionId)
                    }, onFailure: { (error) in
                        onFailure(error)
                    })
                }, onFailure: { (error) in
                    onFailure(error)
                })
            }) { (error) in
                onFailure(error)
            }
        } else {
            self.validateToken(token: self.token!, password: password, onSuccess: { (validatedToken) in
                self.generateSessionId(validatedToken: validatedToken, onSuccess: { (sessionId) in
                    onSuccess(sessionId)
                }, onFailure: { (error) in
                    onFailure(error)
                })
            }, onFailure: { (error) in
                onFailure(error)
            })
        }
        
        
    }
    /*Get account details. In this case, the user ID*/
    func getAccountDetails(onSuccess: @escaping (_ userId: Int) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        let headers: HTTPHeaders = ["content-type": "application/json"]
        Alamofire.request("\(Tmdb.apiRequestBaseUrl)/account?api_key=\(Tmdb.apiKey)&session_id=\(String(describing: self.sessionId!))", method: .get, parameters: nil, headers: headers).validate().responseJSON { (response) in
            guard response.result.isSuccess else {
                onFailure("Request error requesting account details")
                return
            }
            guard let value = response.result.value as? [String: Any] else {
                onFailure("Data received is compromised")
                return
            }
            if let id = value["id"] as? Int {
                self.userId = id
                onSuccess(id)
            } else {
                if let status = value["status_message"] as? String {
                    onFailure(status)
                } else {
                    onFailure("Data received is compromised")
                }
            }
        }
    }
    
    /*Function that requests and returns an unvalidated and temporary token which can be validated and later used to generate a session (user logedin)*/
    func requestToken(onSuccess: @escaping (_ token: String) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        let headers: HTTPHeaders = ["content-type": "application/json"]
        Alamofire.request("\(Tmdb.apiRequestBaseUrl)/authentication/token/new?api_key=\(Tmdb.apiKey)", method: .get, parameters: nil, headers: headers).validate().responseJSON { (response) in
            guard response.result.isSuccess else {
                onFailure("Request error generating token")
                return
            }
            guard let value = response.result.value as? [String: Any] else {
                onFailure("Data received is compromised")
                return
            }
            if let success = value["success"] as? Int {
                if success == 1 {
                    if let token = value["request_token"] as? String {
                        self.token = token
                        onSuccess(token)
                    } else {
                        onFailure("Data received is compromised")
                    }
                } else {
                    onFailure("Failure to generate token")
                }
            } else {
                if let status = value["status_message"] as? String {
                    onFailure(status)
                } else {
                    onFailure("Data received is compromised")
                }
            }
        }
    }
    
    /*Function that requests and returns an valid and temporary token which can be used to generate a session (user logedin)*/
    func validateToken(token: String, password: String, onSuccess: @escaping (_ token: String) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        let headers: HTTPHeaders = ["content-type": "application/json"]
        let parameters: Parameters = [
            "username": self.username!,
            "password": password,
            "request_token": token
        ]
        print(parameters)
        Alamofire.request("\(Tmdb.apiRequestBaseUrl)/authentication/token/validate_with_login?api_key=\(Tmdb.apiKey)", method: .get, parameters: parameters, headers: headers).validate().responseJSON { (response) in
            guard response.result.isSuccess else {
                onFailure("Request error validating token")
                return
            }
            guard let value = response.result.value as? [String: Any] else {
                onFailure("Data received is compromised")
                return
            }
            if let success = value["success"] as? Int {
                if success == 1 {
                    if let token = value["request_token"] as? String {
                        onSuccess(token)
                    } else {
                        onFailure("Data received is compromised")
                    }
                } else {
                    onFailure("Failure to validate token")
                }
            } else {
                if let status = value["status_message"] as? String {
                    onFailure(status)
                } else {
                    onFailure("Data received is compromised")
                }
            }
        }
    }
    
    /*Function responsible for generate an session id. Basically login in the user*/
    func generateSessionId(validatedToken: String, onSuccess: @escaping (_ token: String) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        let headers: HTTPHeaders = ["content-type": "application/json"]
        let parameters: Parameters = [
            "request_token": validatedToken
        ]
        Alamofire.request("\(Tmdb.apiRequestBaseUrl)/authentication/session/new?api_key=\(Tmdb.apiKey)", method: .get, parameters: parameters, headers: headers).validate().responseJSON { (response) in
            guard response.result.isSuccess else {
                onFailure("Request error generating session id")
                return
            }
            guard let value = response.result.value as? [String: Any] else {
                onFailure("Data received is compromised")
                return
            }
            if let success = value["success"] as? Int {
                if success == 1 {
                    if let sessionId = value["session_id"] as? String {
                        self.sessionId = sessionId
                        onSuccess(sessionId)
                    } else {
                        onFailure("Data received is compromised")
                    }
                } else {
                    onFailure("Failure to generate session")
                }
            } else {
                if let status = value["status_message"] as? String {
                    onFailure(status)
                } else {
                    onFailure("Data received is compromised")
                }
            }
        }
    }
    
    /*Function responsible for logout the user*/
    func logout(onSuccess: @escaping (_ logedOut: Bool) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        let headers: HTTPHeaders = ["content-type": "application/json"]
        let parameters: Parameters = [
            "session_id": self.sessionId!
        ]
        Alamofire.request("\(Tmdb.apiRequestBaseUrl)/authentication/session?api_key=\(Tmdb.apiKey)", method: .delete, parameters: parameters, headers: headers).validate().responseJSON { (response) in
            guard response.result.isSuccess else {
                onFailure("Request error in logout")
                return
            }
            guard let value = response.result.value as? [String: Any] else {
                onFailure("Data received is compromised")
                return
            }
            if let success = value["success"] as? Int {
                if success == 1 {
                    onSuccess(true)
                } else {
                    onFailure("Failure in logout")
                }
            } else {
                if let status = value["status_message"] as? String {
                    onFailure(status)
                } else {
                    onFailure("Data received is compromised")
                }
            }
        }
    }
    
}
