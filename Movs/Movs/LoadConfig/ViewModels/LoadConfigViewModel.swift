//
//  LoadConfigViewModel.swift
//  Movs
//
//  Created by Filipe Jordão on 24/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoadConfigViewModelInput {
    func trigger() -> Driver<Void>
}

protocol LoadConfigViewModelOutput {
    func finishedLoading(_ trigger: Observable<TheMovieDBConfig>)
    func error(_ trigger: Driver<Void>)
}

class LoadConfigViewModel {
    let configProvider: ConfigProvider
    let disposeBag = DisposeBag()

    init(view: LoadConfigViewModelInput & LoadConfigViewModelOutput, configProvider: ConfigProvider) {
        self.configProvider = configProvider

        let result = request(view.trigger().asObservable())

        let finished = result.map { _ in Void() }
                             .asDriver(onErrorJustReturn: Void())

        view.finishedLoading(result)
        view.error(finished)
    }

    func request(_ observable: Observable<Void>) -> Observable<TheMovieDBConfig> {
        return observable.flatMap(configProvider.config)
    }
}
