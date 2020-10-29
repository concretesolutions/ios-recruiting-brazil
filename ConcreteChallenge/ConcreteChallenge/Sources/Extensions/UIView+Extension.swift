//
//  UIView+Extension.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 26/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

extension UIView {
    static let loadingViewTag = 1964851847

    // MARK: - Functions

    func showLoading(style: UIActivityIndicatorView.Style = .medium) {
        var loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
        if loading == nil {
            loading = UIActivityIndicatorView(style: .medium)
        }

        if let loading = loading {
            loading.translatesAutoresizingMaskIntoConstraints = false
            loading.startAnimating()
            loading.tag = UIView.loadingViewTag

            let view = UIView()
            view.backgroundColor = .white

            view.addSubviewEqual(equalConstraintFor: loading)
            addSubviewEqual(equalConstraintFor: view)

            NSLayoutConstraint.activate([
                loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                loading.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
    }

    func stopLoading() {
        if let loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView, let parentView = loading.superview {
            loading.stopAnimating()
            parentView.removeFromSuperview()
            loading.removeFromSuperview()
        }
    }

    func hasLoading() -> Bool {
        return viewWithTag(UIView.loadingViewTag) is UIActivityIndicatorView
    }

    func addSubview<T: UIView>(_ view: T, affectedViews: [T] = [], constraints: [NSLayoutConstraint]) {
        addSubview(view, affectedViews: affectedViews)

        NSLayoutConstraint.activate(constraints)
    }

    func addSubviewEqual<T: UIView>(equalConstraintFor view: T, affectedViews: [T] = []) {
        addSubview(view, affectedViews: affectedViews)

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Private functions

    private func addSubview<T: UIView>(_ view: T, affectedViews: [T]) {
        addSubview(view)

        [affectedViews + [view]].flatMap(Set.init).forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
