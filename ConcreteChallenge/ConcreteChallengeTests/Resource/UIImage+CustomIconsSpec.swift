//
//  UIImage+CustomIconsSpec.swift
//  ConcreteChallengeTests
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import Quick
import Nimble

@testable import ConcreteChallenge

class UIImageCustomIconsSpec: QuickSpec {

    override func spec() {
        describe("UIImage+CustomIcons") {

            it("should not have nil images") {

                expect(UIImage.placeholder).toNot(beNil())
                expect(UIImage.listIcon).toNot(beNil())
                expect(UIImage.Favorite.emptyIcon).toNot(beNil())
                expect(UIImage.Favorite.fullIcon).toNot(beNil())
                expect(UIImage.Favorite.grayIcon).toNot(beNil())
            }
        }
    }
}
