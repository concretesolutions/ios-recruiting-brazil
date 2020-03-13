//
//  ListMovsServiceType.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 07/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import NetworkLayerModule

protocol ListMovsServiceType: AnyObject {
    func fetchDatas(typeData: ListMovsDataType, handler completion: @escaping (Result<MovsListRequestModel, MtdbAPIError>) -> Void )
    func absoluteUrlImage(with url: String) -> String
    func stopRequest()
}
