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
    func finishedLoading(_ trigger: Observable<MovsConfig>)
}

class LoadConfigViewModel {
    typealias View = LoadConfigViewModelInput & LoadConfigViewModelOutput
    let configProvider: ConfigProvider
    let configStore: ConfigStore
    let disposeBag = DisposeBag()

    init(view: View, configProvider: ConfigProvider, configStore: ConfigStore) {
        self.configProvider = configProvider
        self.configStore = configStore

        let result = handleError(on: request(view.trigger().asObservable()))

        result.subscribe(onNext: { configStore.store(config: $0) })
              .disposed(by: disposeBag)

        view.finishedLoading(result)
    }

    func request(_ observable: Observable<Void>) -> Observable<MovsConfig> {
        let genres = observable.flatMap(configProvider.genres)
        let config = observable.flatMap(configProvider.config)

        return
            Observable.zip(genres, config)
            .map { genres, config in
                let movsGenres = genres.genres.map { MovsGenre(identifier: $0.identifier, name: $0.name) }
                let imageProvider = config.images.secureBaseURL

                return MovsConfig(imageProvider: imageProvider, genres: movsGenres)
            }
    }

    func handleError(on observable: Observable<MovsConfig>) -> Observable<MovsConfig> {
        return observable
            .catchError { _ in
                let config = self.configStore.config()
                return config.map(Observable.just) ?? Observable.empty()
            }
    }
}
