//
//  SnapshotTesting+Extension.swift
//  MovsTests
//
//  Created by Adrian Almeida on 03/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Movs
import XCTest

extension XCTestCase {
    func setRootViewController(_ viewController: UIViewController) {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        keyWindow?.rootViewController = viewController
        keyWindow?.makeKeyAndVisible()

        viewController.beginAppearanceTransition(true, animated: true)
        viewController.endAppearanceTransition()
    }

    func popRootViewController() {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        keyWindow?.rootViewController?.navigationController?.popToRootViewController(animated: false)
        keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
    }

    func clearRootViewController() {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        keyWindow?.rootViewController = UINavigationController(
            rootViewController: UIViewController()
        )
    }

    // MARK: - ViewCode functions

    @discardableResult
    func addSubviewForTest<T: UIView>(_ view: T) -> UIViewController {
        addSubviewForTest(view, constraints: { viewController in [
            view.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor)
        ]})
    }

    @discardableResult
    func addSubviewForTest<T: UIView>(equalConstraintsFor view: T) -> UIViewController {
        addSubviewForTest(view, constraints: { viewController in [
            view.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
        ]})
    }

    @discardableResult
    func addSubviewForTest<T: UIView>(_ view: T, constraints: (UIViewController) -> [NSLayoutConstraint]) -> UIViewController {
        let viewController = UIViewController(nibName: nil, bundle: nil)

        viewController.view.addSubview(view, constraints: constraints(viewController))
        viewController.beginAppearanceTransition(true, animated: true)
        viewController.endAppearanceTransition()

        return viewController
    }
}
