//
//  ConfigProvider.swift
//  Movs
//
//  Created by Filipe Jordão on 24/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation
import RxSwift

protocol ConfigProvider {
    func config() -> Observable<TheMovieDBConfig>
    func genres() -> Observable<GenresResponse>
}
