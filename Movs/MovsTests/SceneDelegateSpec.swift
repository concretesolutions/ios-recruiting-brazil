//
//  SceneDelegateSpec.swift
//  MovsTests
//
//  Created by Lucca Ferreira on 02/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Quick
import Nimble
@testable import Movs

class SceneDelegateSpec: QuickSpec {

    override func spec() {

        describe("SceneDelegate") {
            var sceneDelegate: SceneDelegate!
            beforeEach {
                sceneDelegate = SceneDelegate()
                var _ = sceneDelegate
            }
            
            context("has root controller not nil") {
                it("") {
//                    expect(sceneDelegate.window?.rootViewController) != nil
                }
            }
        }

    }

}
