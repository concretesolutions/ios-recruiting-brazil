//
//  BaseWireframe.swift
//  DataMovie
//
//  Created by Andre Souza on 06/07/2018.
//  Copyright © 2018 AndreSamples. All rights reserved.
//

import Foundation
import UIKit

enum Transition {
    case root
    case push
    case present(completion: (() -> Void)?)
    case presentTransition(transitionDelegate: UIViewControllerTransitioningDelegate)
}

protocol WireframeInterface: class {
    func popFromNavigationController(animated: Bool)
    func dismiss(animated: Bool)
    func show(_ wireframe: BaseWireframe, with transition: Transition, animated: Bool)
    func show(_ viewController: UIViewController, with transition: Transition, animated: Bool)
    func showErrorAlert(with message: String?)
    func showAlert(with title: String?, message: String?)
    func showAlert(with title: String?, message: String?, actions: [UIAlertAction])
}

class BaseWireframe {
    
    fileprivate unowned var _viewController: UIViewController
    
    init(viewController: UIViewController) {
        _viewController = viewController
    }
    
}

extension BaseWireframe {
    
    var viewController: UIViewController {
        return _viewController
    }
    
    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
}

extension BaseWireframe: WireframeInterface {
    
    func popFromNavigationController(animated: Bool) {
        let _ = navigationController?.popViewController(animated: animated)
    }
    
    func dismiss(animated: Bool) {
        navigationController?.dismiss(animated: animated)
    }
    
    func show(_ wireframe: BaseWireframe, with transition: Transition, animated: Bool) {
        switch transition {
        case .push:
            navigationController?.pushWireframe(wireframe, animated: animated)
        case .present(let completion):
            let navigation = UINavigationController()
            navigation.setRootWireframe(wireframe)
            _viewController.present(navigation, animated: animated, completion: completion)
        case .presentTransition(let transitionDelegate):
            let navigation = UINavigationController()
            navigation.setRootWireframe(wireframe)
            navigation.transitioningDelegate = transitionDelegate
            navigation.modalPresentationStyle = .custom
            _viewController.present(navigation, animated: animated)
        case .root:
            navigationController?.setRootWireframe(wireframe, animated: animated)
        }
    }
    
    func show(_ viewController: UIViewController, with transition: Transition, animated: Bool) {
        switch transition {
        case .push:
            navigationController?.pushViewController(viewController, animated: animated)
        case .present(let completion):
            _viewController.present(viewController, animated: animated, completion: completion)
        case .presentTransition(let transitionDelegate):
            navigationController?.transitioningDelegate = transitionDelegate
            navigationController?.modalPresentationStyle = .custom
            _viewController.present(viewController, animated: animated)
        case .root:
            navigationController?.setViewControllers([viewController], animated: animated)
        }
    }
    
    func showErrorAlert(with message: String?) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        showAlert(with: "Something went wrong", message: message, actions: [okAction])
    }
    
    func showAlert(with title: String?, message: String?) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        showAlert(with: title, message: message, actions: [okAction])
    }
    
    func showAlert(with title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        alert.view.tintColor = .blueColor
        navigationController?.present(alert, animated: true, completion: nil)
    }

}
