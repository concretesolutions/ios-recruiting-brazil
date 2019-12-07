//
//  BaseViewController.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit
import os.log

class BaseViewController: UIViewController, ViewDelegate {
    
    
    // MARK: - Properties -
    /// The presenter for this view. The use of a typecast is recommended whenever used.
    let presenter: Presenter
    
    /// Variable to enable or disable view's logs
    static var logEnabled: Bool = true
    
    // MARK: - Init -
    init(presenter: Presenter) {
        guard type(of: self) != BaseViewController.self else {
            os_log("❌ - BaseViewController instanciated directly", log: Logger.appLog(), type: .fault)
            fatalError(
                "Creating `BaseViewController` instances directly is not supported. This class is meant to be subclassed."
            )
        }
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.attachView(self)
        
        if BaseViewController.logEnabled {
            os_log("🎮 👶 %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        presenter.detachView()
        if BaseViewController.logEnabled {
            os_log("🎮 ⚰️ %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
        }
    }
    
    // MARK: - View Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: View Setup
    /**
     This method calls the other view setup methods.
     
     - Important: Calling the superclass method is required
     */
    func setupUI() {
        
        addSubviews()
        setupConstraints()
    }
    
    /**
     Override this method to add the subviews of the Controller.
     
     Calling the superclass method is not needed.
     */
    func addSubviews() {}
    
    /**
     Override this method to add the constraints to the subviews of the Controller.
     
     Calling the superclass method is not needed.
     */
    func setupConstraints() {}

    // MARK: - ViewDelegate
    func startLoading() {}
    
    func finishLoading() {}
    
    func exitView() {
        
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func navigateToView(presenter: Presenter) {
        
        let newVC: BaseViewController = BaseViewController(presenter: presenter)
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(newVC, animated: true)
        } else {
            self.present(newVC, animated: true, completion: nil)
        }
    }
}
