//
//  FilterPresenter.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

protocol FilterPresenterView: ViewProtocol {
}

final class FilterPresenter: MVPBasePresenter {
    
    var view:FilterPresenterView? {
        return self.baseView as? FilterPresenterView
    }
}

extension FilterPresenter: FilterViewPresenter {
}
