//
//  ViewModelFactory.swift
//  Movs
//
//  Created by Franclin Cabral on 1/19/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import Foundation

protocol ViewModelFactoryProtocol {
    func viewModel(for screen: ApplicationScreen) -> BaseViewModelProtocol
    func viewModel(for screen: ApplicationScreen, data: Any?) -> BaseViewModelProtocol
    init(factory: FactoryProtocol)
}

class ViewModelFactory: ViewModelFactoryProtocol {
    private var factory: FactoryProtocol
    
    required init(factory: FactoryProtocol) {
        self.factory = factory
    }
    
    func viewModel(for screen: ApplicationScreen) -> BaseViewModelProtocol {
        return viewModel(for: screen, data: nil)
    }
    
    func viewModel(for screen: ApplicationScreen, data: Any?) -> BaseViewModelProtocol {
        var viewModel: BaseViewModelProtocol = BaseViewModel()
        
        switch screen {
        case .main:
            viewModel = MoviesViewModel()
            break
        case .favorites:
            
            break
        case .splash:
            viewModel = SplashViewModel()
            break
        default:
            break
        }
        
        return viewModel
    }
    
    
}
