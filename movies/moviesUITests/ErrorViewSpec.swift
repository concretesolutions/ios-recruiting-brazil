//
//  ErrorViewSpec.swift
//  moviesUITests
//
//  Created by Jacqueline Alves on 09/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Movs

class ErrorViewSpec: QuickSpec {
    override func spec() {
        var sut: ErrorView!
        
        describe("the 'Error View' ") {
            context("in generic errors ") {
                beforeEach {
                    let frame = UIScreen.main.bounds
                    
                    sut = ErrorView(frame: frame, imageName: "error_icon", text: "An error occured. Please try again.")
                }
                
                it("shoud have the expected look and feel.") {
                    expect(sut) == snapshot("GenericErrorView")
                }
            }
            
            context("in no data found errors ") {
                beforeEach {
                    let frame = UIScreen.main.bounds
                    
                    sut = ErrorView(frame: frame, imageName: "search_icon", text: "Your search for \"x\" didn't return anything.")
                }
                
                it("shoud have the expected look and feel.") {
                    expect(sut) == snapshot("NoDataFoundErrorView")
                }
            }
        }
    }
}
