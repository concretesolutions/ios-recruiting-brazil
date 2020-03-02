//
//  StartMain.swift
//  Movs
//
//  Created by Marcos Felipe Souza on 02/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation

///Start Main App
class StartMain {
    private init() {}
    static let shared = StartMain()
    
    /**
        Function that change order on app run.
     */
    func start(appCoordinator: AppCoordinator) {
        appCoordinator.make(scene: .tabBarView([.listMovsFeature, .favoriteFeature]),
                            type: .root)
    }
}
