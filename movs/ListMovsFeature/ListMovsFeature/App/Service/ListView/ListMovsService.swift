//
//  ListMovsService.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 07/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import NetworkLayerModule

class ListMovsService {
    var base: BaseRequestAPI?
}

//MARK: - Implementation Protocol -
extension ListMovsService: ListMovsServiceType {
    func absoluteUrlImage(with url: String) -> String {
        return ListMovsAPI.downloadImage(url).absoluteURL.absoluteString
    }
    
    func fetchDatas(typeData: ListMovsDataType,
                    handler completion: @escaping (Result<MovsListRequestModel, MtdbAPIError>) -> Void ) {
        
        let api = ListMovsAPI.fetch(typeData.rawValue)
        
        self.base = BaseRequestAPI(api: api) { (result: Result<MovsListRequestModel, MtdbAPIError>) in
                switch result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
    
    func stopRequest() {
        self.base?.stop()
    }
}
