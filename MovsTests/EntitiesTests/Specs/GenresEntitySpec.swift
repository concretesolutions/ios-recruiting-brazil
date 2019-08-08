//
//  GenresEntitySpec.swift
//  MovsTests
//
//  Created by Bruno Chagas on 02/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Movs

class GenresEntitySpec: QuickSpec {
    override func spec() {
        
        var sut: GenresEntity?
        
        beforeEach {
            let json =  "{\"genres\":[{\"id\":28,\"name\":\"Action\"},{\"id\":12,\"name\":\"Adventure\"},{\"id\":16,\"name\":\"Animation\"},{\"id\":35,\"name\":\"Comedy\"}]}"
            
            guard let data = json.data(using: .utf8)
            else {
                fail()
                return
            }
            
            do {
                sut = try JSONDecoder().decode(GenresEntity.self, from: data)
            } catch {
                fail()
            }
        }
        describe("A genre array") {
            it("Has to not have empty properties", closure: {
                expect(sut?.genres).toNot(beNil())
            })
        }
        
    }
}
