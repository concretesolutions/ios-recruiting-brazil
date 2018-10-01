//
//  ResponsePopularMoviesSpec.swift
//  ios-recruiting-brazilTests
//
//  Created by André Vieira on 01/10/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Mapper
import Quick
import Nimble

@testable import ios_recruiting_brazil

class ResponsePopularMoviesSpec: QuickSpec {
    
    var response: ResponsePopularMovies?
    var error: Error?
    
    override func spec() {
        
        describe("ResponsePopularMoviesSpec - parse") {
            beforeEach {
                if let path = Bundle.main.path(forResource: "ResponsePopularMovies", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                        if let jsonResult = jsonResult as? NSDictionary{
                            self.response = try ResponsePopularMovies(map: Mapper(JSON: jsonResult))
                        }
                    } catch {
                        self.error = error
                    }
                }
            }
            
            it("page", closure: {
                expect(self.response?.page).to(equal(1))
            })
            
            it("totalResult", closure: {
                expect(self.response?.totalResult).to(equal(19847))
            })
            
            it("totalPage", closure: {
                expect(self.response?.totalPage).to(equal(993))
            })
            
            it("results", closure: {
                expect(self.response?.results.count).to(equal(5))
            })
        }
    }
}
