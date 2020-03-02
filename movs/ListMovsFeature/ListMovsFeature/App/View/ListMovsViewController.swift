//
//  ListMovsViewController.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 02/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import Common


enum ListMovsHandleState {
    case loading
    case success
    case failure(String)
    case tapButton
}

open class ListMovsViewController: BaseViewController {
    
    var presenter: ListMovsPresenter!
    
    var stateUI: ListMovsHandleState = .loading {
        didSet {
            self.stateHandleUI()
        }
    }
    
    let button: UIButton = {
        let view = UIButton(type: UIButton.ButtonType.system)
        view.setTitle("Tap here", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

}

//MARK: - Lifecycle-
extension ListMovsViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupContraints()
        self.presenter.loading()
    }
}

//MARK: -State UI-
extension ListMovsViewController {
    private func stateHandleUI() {
        switch self.stateUI {
        case .loading:
            print("Loading")
        case .success:
            print("Success")
        case .failure(let message):
            print("Error in :\(message)")
        case .tapButton:
            print("Tap Button")
        }
        self.presenter.tapOnButton()
    }
    
    @objc func tapOnButton() {
        self.stateUI = .tapButton
    }
}

//MARK: -Action by Presenter-
extension ListMovsViewController: ListMovsView {
    func loadViewController() {
        self.view.backgroundColor = .systemPink
        self.button.addTarget(self, action: #selector(tapOnButton), for: .touchDown)
    }
}

//MARK: -Setup View-
extension ListMovsViewController {
    func setupContraints() {
        self.view.addSubview(self.button)
        NSLayoutConstraint.activate([
            self.button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.button.heightAnchor.constraint(equalToConstant: 150),
        ])
        
    }
}

