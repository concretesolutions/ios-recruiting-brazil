//
//  BasePresenter.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation
import os.log

class BasePresenter: Presenter {
    
    // MARK: - Properties -
    private(set) weak var view: ViewDelegate?
    
    /// Variable to enable or disable presenter's logs
    static var logEnabled: Bool = true
    
    // MARK: - Init -
    init() {
        guard type(of: self) != BasePresenter.self else {
            os_log("❌ - BasePresenter instanciated directly", log: Logger.appLog(), type: .fault)
            fatalError(
                "Creating `BasePresenter` instances directly is not supported. This class is meant to be subclassed."
            )
        }
        
        if BasePresenter.logEnabled {
            os_log("🖥 👶 %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
        }
    }
    
    deinit {
        if BasePresenter.logEnabled {
            os_log("🖥 ⚰️ %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
        }
    }
    
    // MARK: - Methods -
    func attachView(_ view: ViewDelegate) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
}
