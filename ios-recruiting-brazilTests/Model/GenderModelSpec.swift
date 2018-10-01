//
//  GenderModelSpec.swift
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

class GenderModelSpec: QuickSpec {
    
    var gender: GenderModel?
    var RLMGenderModel: RLMGenderModel?
    var error: Error?
    
    override func spec() {
        
        beforeEach {
            if let path = Bundle.main.path(forResource: "GenderMock", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let jsonResult = jsonResult as? NSDictionary{
                        self.gender = try GenderModel(map: Mapper(JSON: jsonResult))
                        self.RLMGenderModel = self.gender?.asRealm()
                    }
                } catch {
                    self.error = error
                }
            }
        }
        
        describe("GenderModelSpec - parse") {
            
            it("id", closure: {
                expect(self.gender?.id).to(equal(28))
            })
            
            it("posterPath", closure: {
                expect(self.gender?.name).to(equal("Action"))
            })
        }
        
        describe("GenderModelSpec - asRealm") {
            it("id", closure: {
                expect(self.RLMGenderModel?.id).to(equal(28))
            })
            
            it("posterPath", closure: {
                expect(self.RLMGenderModel?.name).to(equal("Action"))
            })
        }
    }
}
