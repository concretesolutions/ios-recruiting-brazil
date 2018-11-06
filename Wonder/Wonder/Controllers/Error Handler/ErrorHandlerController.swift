//
//  ErrorHandlerController.swift
//  Wonder
//
//  Created by Marcelo on 06/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

class ErrorHandlerController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var refreshButton: UIButton!
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        uiAppearance()
        
        // oberserver manager
        observerManager()

        
    }
    
    // MARK: - UI Appearance
    private func uiAppearance() {
        self.view.backgroundColor = UIColor.applicationBarTintColor
        self.refreshButton.layer.cornerRadius = 8
        self.refreshButton.layer.masksToBounds = true
        self.refreshButton.layer.borderColor = UIColor.black.cgColor
        self.refreshButton.layer.borderWidth = 1
    }
    
    // MARK: UI Actions
    @IBAction func refreshAction(_ sender: Any) {
        print("♻️ refresh connection")
        
        if AppSettings.standard.internetConnectionStatus() {
            
            // dismiss view controller
            dismissErrorHandlerView()
            
        }
        
        
    }
    
    
    // MARK: - Navigation Helpers
    private func dismissErrorHandlerView() {
        // dismiss view controller
        navigationController?.dismiss(animated: true
            , completion: {
                // completion
        })
    }
    
    
    
    // MARK: - Observers
    private func observerManager() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didConnectToInternet),
                                               name: NSNotification.Name(rawValue: "didConnectToInternet"),
                                               object: nil)
    }
    
    // observer actions
    @objc private func didConnectToInternet() {
        
        print("🇧🇷 did Connect To Internet 👍")
        // dismiss view controller
        dismissErrorHandlerView()
        
    }

    
    
}
