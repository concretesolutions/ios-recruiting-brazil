//
//  ImagesDataSource.swift
//  Movs
//
//  Created by Dielson Sales on 03/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit
import RxSwift

protocol ResourcesDataSource {
    func requestImage(resource: String) -> Single<UIImage?>
}

class ResourcesDataSourceImpl: ResourcesDataSource {

    func requestImage(resource: String) -> Single<UIImage?> {
        return requestConfiguration().flatMap { (configuration: Configuration?) -> Single<UIImage?> in
            if let configuration = configuration {
                let imagesURL = "\(configuration.imagesConfiguration.secureBaseURL)/w342\(resource)"
                return requestData(url: imagesURL).map({ UIImage(data: $0) })
            } else {
                return Single.error(MovErrors.genericError)
            }
        }
    }

    private func requestConfiguration() -> Single<Configuration?> {
        let configurationURL = "\(NetworkClientConstants.baseURL)/configuration"
        return requestData(url: configurationURL).map({ (data: Data) -> Configuration? in
            return parseDecodable(from: data)
        })
    }
}
