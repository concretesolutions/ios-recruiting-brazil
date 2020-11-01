//
//  FilterPresenter.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol FilterPresentationLogic: AnyObject {
    func onFetchGenresSuccess(response: Filter.FetchGenres.Response)
    func onFetchGenresFailure()
}

final class FilterPresenter: FilterPresentationLogic {
    weak var viewController: FilterDisplayLogic?

    // MARK: - FilterPresentationLogic conforms

    func onFetchGenresSuccess(response: Filter.FetchGenres.Response) {
        viewController?.onFetchGenresSuccessful(genres: response.genres)
    }

    func onFetchGenresFailure() {
        viewController?.onFetchGenresFailure()
    }
}
