//
//  FilterViewController.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

import UIKit

protocol FilterViewPresenter: PresenterProtocol {
}

final class FilterViewController: MVPBaseViewController, FilterPresenterView {
    var presenter: FilterViewPresenter? {
        get {
            return self.basePresenter as? FilterViewPresenter
        }
        set {
            self.basePresenter = newValue
        }
    }
}
