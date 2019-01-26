//
//  LoadConfigViewController.swift
//  Movs
//
//  Created by Filipe Jordão on 24/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoadConfigViewController: UIViewController {
    let disposeBag = DisposeBag()
    let loadConfigView = LoadConfigView()
    var coordinator: LoadConfigCoordinator?

    override func loadView() {
        super.loadView()
        view = loadConfigView
    }
}

extension LoadConfigViewController: LoadConfigViewModelInput {
    func trigger() -> Driver<Void> {
        return rx.sentMessage(#selector(viewDidLoad))
                .map { _ in Void() }
                .asDriver(onErrorJustReturn: Void())
    }
}

extension LoadConfigViewController: LoadConfigViewModelOutput {
    func finishedLoading(_ trigger: Observable<MovsConfig>) {
        guard let coordinator = coordinator else { return }
        coordinator.next(from: self, with: trigger)
    }

    func error(_ trigger: Driver<Void>) {
        trigger.drive(onNext: { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.showError()
        })
        .disposed(by: disposeBag)
    }

    func showError() {
        let alert = UIAlertController(title: "Ooops",
                                      message: "Algo de errado aconteceu. Tente novamente mais tarde.",
                                      preferredStyle: .alert)

        let okAction = UIAlertAction(title: "ok", style: .default)

        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
