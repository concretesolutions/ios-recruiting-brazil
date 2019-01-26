//
//  LoadConfigCoordinator.swift
//  Movs
//
//  Created by Filipe Jordão on 24/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import UIKit
import RxSwift

class LoadConfigCoordinator {
    let disposeBag = DisposeBag()

    func create() -> UIViewController {
        let loadVc = LoadConfigViewController()
        loadVc.coordinator = self
        let configProvider = TheMovieDBConfigProvider()
        let configStore = MovsConfigStore()
        _ = LoadConfigViewModel(view: loadVc, configProvider: configProvider, configStore: configStore)

        return loadVc
    }

    func next(from viewController: UIViewController, with config: Observable<MovsConfig>) {
        config.subscribe(onNext: { config in
            let tabBarVc = TabBarCoordinator().create(with: config)
            tabBarVc.modalTransitionStyle = .crossDissolve
            viewController.present(tabBarVc, animated: true)
        })
        .disposed(by: disposeBag)
    }
}
