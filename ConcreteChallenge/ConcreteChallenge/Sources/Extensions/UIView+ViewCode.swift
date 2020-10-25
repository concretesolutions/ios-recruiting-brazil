////
////  UIView+ViewCode.swift
////  ConcreteChallenge
////
////  Created by Adrian Almeida on 25/10/20.
////  Copyright © 2020 Adrian Almeida. All rights reserved.
////
//
//import UIKit
//
//extension UIView {
//    func addSubview<T: UIView>(_ view: T, affectedViews: [T] = [], constraints: [NSLayoutConstraint]) {
//        addSubview(view, affectedViews: affectedViews)
//
//        NSLayoutConstraint.activate(constraints)
//    }
//
//    func addSubviewAllEdges<T: UIView>(equalConstraintsFor view: T, affectedViews: [T] = []) {
//        addSubview(view, affectedViews: affectedViews)
//
//        NSLayoutConstraint.activate([
//            view.topAnchor.constraint(equalTo: topAnchor),
//            view.leadingAnchor.constraint(equalTo: leadingAnchor),
//            view.trailingAnchor.constraint(equalTo: trailingAnchor),
//            view.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
//
//    // MARK: - Private functions
//
//    private func addSubview<T: UIView>(_ view: T, affectedViews: [T]) {
//        addSubview(view)
//
//        [affectedViews + [view]].flatMap(Set.init).forEach { view in
//            view.translatesAutoresizingMaskIntoConstraints = false
//        }
//    }
//}
