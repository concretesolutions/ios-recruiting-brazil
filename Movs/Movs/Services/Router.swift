//
//  Router.swift
//  Movs
//
//  Created by Franclin Cabral on 1/18/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import Foundation
import UIKit

typealias BaseVController = UIViewController & BaseController

protocol BaseViewModelProtocol { } //TODO: Remover dumb protocol, substituir por algo em comum

protocol BaseController {
    var baseViewModel: BaseViewModelProtocol! { get set }
}

class BaseViewModel: BaseViewModelProtocol {
    
}

protocol RouterProtocol {
    var window: UIWindow? { get set }
    var viewModelFactory: ViewModelFactory { get set }
    
    func route(from viewController: UIViewController, to screen: ApplicationScreen)
    func route(from viewController: UIViewController, to screen: ApplicationScreen, data: Any?)
    func route(from viewController: UIViewController, to screen: ApplicationScreen, data: Any?, action: RouteAction)
    func route(from viewController: UIViewController, to screen: ApplicationScreen, action: RouteAction)
    func route(from viewController: UIViewController, to screen: ApplicationScreen, data: Any?, action: RouteAction, completion:(() -> Void)?)
    func changeRoot(to screen: ApplicationScreen)
}

enum ApplicationStoryboard: String {
    case main = "Main"
    case splash = "Splash"
    
    var storyboard: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}

protocol StoryboardItem {
    static func containerStoryboard() -> ApplicationStoryboard
    static func nameInStoryboard() -> String
}

extension StoryboardItem {
    static func nameInStoryboard() -> String {
        return String(describing: self)
    }
}


enum ApplicationScreen {
    case main
    case favorites
    case filter
    case splash
    case tabbar
    case movieDetail
    
    var storyboardItem: StoryboardItem.Type {
        switch self {
        case .main:
            return MoviesViewController.self
        case .favorites:
            return FavoritesViewController.self
        case .splash:
            return SplashViewController.self
        case .filter:
            return MoviesViewController.self
        case .tabbar:
            return TabBarViewController.self
        case .movieDetail:
            return MovieDetailViewController.self
        }
    }
    
    func viewController() -> BaseVController {
        return self.storyboardItem.containerStoryboard().storyboard.instantiateViewController(withIdentifier: self.storyboardItem.nameInStoryboard()) as! BaseVController
    }
}

enum RouteAction {
    case push
    case pop
    case present
    case dismiss
}

class Router: RouterProtocol {
    weak var window: UIWindow?
    var viewModelFactory: ViewModelFactory
    
    init(viewModelFactory: ViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }
    
    func route(from viewController: UIViewController, to screen: ApplicationScreen, data: Any?, action: RouteAction = .push, completion:(() -> Void)?) {
        
        switch action {
        case .push:
            let vc = wrappedViewController(for: screen, data: data)
            viewController.navigationController?.pushViewController(vc, animated: true)
            if let end = completion {
                end()
            }
            break
        case .pop:
            viewController.navigationController?.popViewController(animated: true)
            if let end = completion {
                end()
            }
            break
        case .present:
            let vc = wrappedViewController(for: screen, data: data)
            viewController.present(vc, animated: true, completion: {
                if let end = completion {
                    end()
                }
            })
            break
        case .dismiss:
            viewController.dismiss(animated: true, completion: {
                if let end = completion {
                    end()
                }
            })
            break
        }
    }
    
    func route(from viewController: UIViewController, to screen: ApplicationScreen, action: RouteAction = .push) {
        self.route(from: viewController, to: screen, data: nil, action: action, completion: nil)
    }
    
    func route(from viewController: UIViewController, to screen: ApplicationScreen) {
        self.route(from: viewController, to: screen, data: nil, action: .push, completion: nil)
    }
    
    func route(from viewController: UIViewController, to screen: ApplicationScreen, data: Any? = nil) {
        self.route(from: viewController, to: screen, data: data, action: .push, completion: nil)
    }
    
    func route(from viewController: UIViewController, to screen: ApplicationScreen, data: Any?, action: RouteAction) {
        self.route(from: viewController, to: screen, data: data, action: action, completion: nil)
    }

    
    func wrappedViewController(for screen: ApplicationScreen, data: Any?) -> UIViewController {
        var vc = screen.viewController()
        let vm = viewModelFactory.viewModel(for: screen, data: data)
        vc.baseViewModel = vm
        var wrapped: UIViewController = vc
        switch screen {
        case .main:
            let nav = UINavigationController(rootViewController: vc)
            nav.isToolbarHidden = false
            if #available(iOS 11.0, *) {
                nav.navigationItem.largeTitleDisplayMode = .always
            }
            wrapped = nav
            break
        case .favorites:
            wrapped = vc
            break
        case .filter:
            wrapped = vc
            break
        case .splash:
            wrapped = vc
            break
        case .tabbar:
            //Movies
            ((vc as! TabBarViewController).viewControllers?[0] as! MoviesViewController)
                .baseViewModel = viewModelFactory.viewModel(for: .main, data: nil)
            //Favorite
            ((vc as! TabBarViewController).viewControllers?[1] as! FavoritesViewController)
                .baseViewModel = viewModelFactory.viewModel(for: .favorites, data: nil)
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = false
            if #available(iOS 11.0, *) {
                nav.navigationItem.largeTitleDisplayMode = .always
            }
            wrapped = nav
            break
        case .movieDetail:
            wrapped = vc
            break
        }
        
        return wrapped
    }
    
    func changeRoot(to screen: ApplicationScreen) {
        self.window?.rootViewController = wrappedViewController(for: screen, data: nil)
    }
    
}
