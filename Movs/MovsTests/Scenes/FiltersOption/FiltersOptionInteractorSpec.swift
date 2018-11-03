//
//  FiltersOptionInteractorSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class FiltersOptionInteractorSpec: QuickSpec {
    override func spec() {
        describe("FiltersOptionInteractor Spec") {
            
            var interactor: FiltersOptionInteractor!
            
            context("select filter") {
                
                beforeEach {
                    interactor = FiltersOptionInteractor()
                    interactor.presenter = FiltersOptionsPresenterStub()
                }
                
                it("should return date filters") {
                    let date = "DateFilter"
                    interactor.dates.append(date)
                    let (predicate, name) = interactor.selectFilter(at: 0)
                    expect(predicate).to(equal(date))
                    expect(name).to(equal(date))
                }
                
                it("should return genre filters") {
                    let id = 1
                    let genre = "genreFilter"
                    interactor.genresIds.append(id)
                    interactor.genresNames.append(genre)
                    let (predicate, name) = interactor.selectFilter(at: 0)
                    expect(predicate).to(equal(String(id)))
                    expect(name).to(equal(genre))
                }
            }
        }
    }
}

