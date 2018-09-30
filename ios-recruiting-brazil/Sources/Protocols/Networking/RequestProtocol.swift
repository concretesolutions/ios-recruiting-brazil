//
//  RequestProtocol.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Mapper
import Moya
import RxSwift

public protocol RequestProtocol {
    associatedtype Target: TargetType
    func requestArray<Model: Mappable>(_ target: Target) -> Observable<[Model]>
    func requestObject<Model: Mappable>(_ target: Target) -> Observable<Model>
    func requestJSON(_ target: Target) -> Observable<Response>
}
