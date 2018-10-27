//
//  GeneralMVP.swift
//  Movs
//
//  Created by Gabriel Reynoso on 22/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

public protocol PresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}

public extension PresenterProtocol {
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
}

public protocol ViewProtocol: NSObjectProtocol {
    func setupOnce()
    func setupWhenAppear()
}

public extension ViewProtocol {
    func setupOnce() {}
    func setupWhenAppear() {}
}

open class MVPBasePresenter: PresenterProtocol {
    
    unowned var baseView:ViewProtocol
    weak var coordinator:Coordinator?
    
    init(view:ViewProtocol, coordinator:Coordinator? = nil) {
        self.baseView = view
        self.coordinator = coordinator
    }
    
    open func viewDidLoad() {
        self.baseView.setupOnce()
    }
    
    open func viewWillAppear() {
        self.baseView.setupWhenAppear()
    }
    
    open func viewWillDisappear() {}
    open func viewDidDisappear() {}
}

open class MVPBaseViewController: UIViewController {
    
    var basePresenter: PresenterProtocol?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.basePresenter?.viewDidLoad()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.basePresenter?.viewWillAppear()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.basePresenter?.viewWillDisappear()
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.basePresenter?.viewDidDisappear()
    }
}
