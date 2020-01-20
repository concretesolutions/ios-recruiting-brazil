//
//  EmptyStateViewSpec.swift
//  ConcreteChallengeTests
//
//  Created by Kaique Damato on 19/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import ConcreteChallenge

class EmptyStateViewSpec: QuickSpec {
    override func spec() {
        
        let view = UIView(frame: UIScreen.main.bounds)
        let emptyStateView = EmptyStateView()
        
        describe("set up view") {
            
            beforeEach {
                view.backgroundColor = .white
                view.addSubview(emptyStateView)
                
                emptyStateView.translatesAutoresizingMaskIntoConstraints = false
                emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
                emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
                emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
            }
            
            afterEach {
                emptyStateView.removeFromSuperview()
            }
            
            it("with request error layout") {
                emptyStateView.state = .requestError
                
                expect(view).toEventually( haveValidSnapshot() )
            }
            
            it("with empty favorites layout") {
                emptyStateView.state = .emptyFavorites
                
                expect(view).toEventually( haveValidSnapshot() )
            }
            
            it("with empty search layout") {
                emptyStateView.state = .emptySearch
                
                expect(view).toEventually( haveValidSnapshot() )
            }
        }
    }
}
