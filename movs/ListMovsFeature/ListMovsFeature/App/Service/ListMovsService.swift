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
    func fetchDatas(typeData: ListMovsDataType,
                    handler completion: @escaping (Result<MovsListViewData, MtdbAPIError>) -> Void ) {
        
        let api = ListMovsAPI.fetch(typeData.rawValue)
        
        self.base = BaseRequestAPI(api: api) { (result: Result<MovsListRequestModel, MtdbAPIError>) in
                switch result {
                case .success(let model):
                    let viewData = self.wrapperModels(from: model)
                    completion(.success(viewData))
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
    
    func loadImage(with url: String, completion: @escaping (Result<Data, MtdbAPIError>) -> Void ) {
        let api = ListMovsAPI.downloadImage(url)
        self.base = BaseRequestAPI(api: api, completion: { result in
            completion(result)
        })
    }
    
    func stopRequest() {
        self.base?.stop()
    }
}

//MARK: -Aux Functions-
extension ListMovsService {
    private func wrapperModels(from requestModel: MovsListRequestModel) -> MovsListViewData {
        var viewData = MovsListViewData()
        requestModel.items?.forEach { item in
            viewData.items.append(MovsItemViewData(imageMovieURL: item.posterPath ?? "/", isFavorite: false, movieName: item.name ?? ""))
        }
        return viewData
    }
}
