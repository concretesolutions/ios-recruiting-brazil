//
//  ImagesDataSource.swift
//  Movs
//
//  Created by Dielson Sales on 03/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit
import RxSwift

protocol ImagesDataSource {
    func requestImage(url: URL) -> Single<UIImage?>
}

class ImagesDataSourceImpl: ImagesDataSource {

    func requestImage(url: URL) -> Single<UIImage?> {
        return requestData(url: url).map({ UIImage(data: $0) })
    }

}
