//
//  UIViewHelperSpec.swift
//  concreto-filmesTests
//
//  Created by Leonel Menezes on 02/11/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import concreto_filmes

class UIViewHelperSpec: QuickSpec {
    
    override func spec() {
        describe("Gradient") {
            var view: UIView!
            
            beforeEach {
                view = UIView()
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = .white
            }
            
            it("Should have aditional layer", closure: {
                expect(view.layer.sublayers?.count).to(beNil())
                view.applyGradient(colours: [.clear, .black])
                expect(view.layer.sublayers?.count == 1).to(beTruthy())
            })
            
            it("should delete gradient layer", closure: {
                view.applyGradient(colours: [.clear, .black])
                view.removeGradientLayer()
                expect(view.layer.sublayers?.count).to(beNil())
            })
        }
    }
}
