//
//  GradientViewTests.swift
//  ConcreteChallengeTests
//
//  Created by Kaique Damato on 19/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import ConcreteChallenge

class GradientViewTests: QuickSpec {
    override func spec() {
        
        var gradientView = GradientView()
        
        describe("set up view") {
            
            beforeEach {
                gradientView = GradientView()
                gradientView.frame = UIScreen.main.bounds
            }
            
            it("with basic layout") {
                expect(gradientView).to( haveValidSnapshot() )
            }
            
            it("with different gradient colors") {
                gradientView.colors = [UIColor.green.cgColor, UIColor.yellow.cgColor]
                
                expect(gradientView).to( haveValidSnapshot() )
            }
            
            it("with different start point") {
                gradientView.startPoint = CGPoint(x: 0, y: 0)
                
                expect(gradientView).to( haveValidSnapshot() )
            }
            
            it("with different end point") {
                gradientView.endPoint = CGPoint(x: 0, y: 0.5)
                
                expect(gradientView).to( haveValidSnapshot() )
            }
            
            it("with different type") {
                gradientView.type = .conic
                
                expect(gradientView).to( haveValidSnapshot() )
            }
            
            it("with different locations") {
                gradientView.locations = [0, 1]
                
                expect(gradientView).to( haveValidSnapshot() )
            }
        }
    }
}
