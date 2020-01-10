//
//  BuilderChainSpec.swift
//  ConcreteChallengeTests
//
//  Created by Marcos Santos on 22/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import Quick
import Nimble

@testable import ConcreteChallenge

class BuilderChainSpec: QuickSpec {

    override func spec() {

        describe("BuilderChain") {

            let testString = "testSet"

            it("should set a property and return the object") {
                let label = UILabel()

                expect(label.text).to(beNil())

                let label2 = label.set(\.text, to: testString)

                expect(label.text).to(equal(testString))
                expect(label).to(equal(label2))
            }

            it("should run closure on object and return it") {
                let label = UILabel()

                expect(label.text).to(beNil())

                let label2 = label.run { label in
                    label.text = testString
                }

                expect(label.text).to(equal(testString))
                expect(label).to(equal(label2))
            }
        }
    }
}
