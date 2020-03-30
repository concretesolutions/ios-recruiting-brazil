//
//  ListServiceMock.swift
//  ListMovsFeatureTests
//
//  Created by Marcos Felipe Souza on 30/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation
import NetworkLayerModule
@testable import ListMovsFeature

class ListServiceMock: ListMovsServiceType {
    
    var isSuccess: Bool
    
    init(success: Bool) {
        self.isSuccess = success
    }
    
    
    func fetchDatas(typeData: ListMovsDataType, handler completion: @escaping (Result<MovsListRequestModel, MtdbAPIError>) -> Void) {
        
        if isSuccess {
            do {
                let bundleMain = BundleMain()
                if let data = bundleMain.file(with: "listMovies") {
                    let model: MovsListRequestModel = try JSONDecoder().decode(MovsListRequestModel.self, from: data)
                    completion(.success(model))
                } else {
                    completion(.failure(.jsonDecoded))
                }
            } catch {
                completion(.failure(.jsonDecoded))
            }
        } else {
            completion(.failure(.badRequest))
        }
    }
    
    func absoluteUrlImage(with url: String) -> String {
        return "urlAbsoluteImage"
    }
    
    func stopRequest() {}
}
