//
//  SettingServices.swift
//  Movs
//
//  Created by Marcos Lacerda on 08/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

typealias SettingsCallback = ((Result<Settings>) -> Void)

class SettingServices: ServicesBase {
  
  public static let shared = SettingServices()
  
  fileprivate override init() {}
  
  internal func fetchSettings(_ handler: @escaping SettingsCallback) {
    let url = self.makeURL(.settings)

    Alamofire.request(url, method: .get, parameters: defaultParams).responseDecodableObject(keyPath: "images", decoder: decoder) { (response: DataResponse<Settings>) in
      
      switch response.result {
      case .success(let settings):
        handler(.success(settings))

      case .failure(let error):
        let errorMessage = self.parseError(error)
        handler(.error(errorMessage))
      }
    }
  }
  
}
