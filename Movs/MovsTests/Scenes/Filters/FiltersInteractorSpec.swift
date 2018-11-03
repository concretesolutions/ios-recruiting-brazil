//
//  FiltersInteractorSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class FiltersInteractorSpec: QuickSpec {
    override func spec() {
        describe("FiltersInteractor Spec") {
            
            var interactor: FiltersInteractor!
            
            context("store type") {
                
                beforeEach {
                    let presenter = FiltersPresenterStub()
                    interactor = FiltersInteractor()
                    interactor.presenter = presenter
                }
                
                it("should have date filter stored") {
                    let request = Filters.Request(type: .date)
                    interactor.storeFilter(request: request)
                    expect(interactor.type).to(equal(.date))
                }
            }
        }
    }
}

