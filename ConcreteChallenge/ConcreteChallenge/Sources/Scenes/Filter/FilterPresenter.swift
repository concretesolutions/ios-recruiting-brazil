//
//  FilterPresenter.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol FilterPresentationLogic: AnyObject {

}

final class FilterPresenter: FilterPresentationLogic {
    weak var viewController: FilterDisplayLogic?
}
