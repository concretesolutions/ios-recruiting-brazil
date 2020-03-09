//
//  ListMovsServiceType.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 07/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import NetworkLayerModule

protocol ListMovsServiceType: AnyObject {
    func fetchDatas(typeData: ListMovsDataType, handler completion: @escaping (Result<MovsListViewData, MtdbAPIError>) -> Void )
    func loadImage(with url: String, completion: @escaping (Result<Data, MtdbAPIError>) -> Void )
    func stopRequest()
}
