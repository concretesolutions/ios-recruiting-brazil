//
//  ViewState.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import Foundation

class ViewState<T, E> : ObserverProtocol {
    
    var id: Int = 123
    
    var successBehavior: Observable<T> = Observable(value: nil)
    
    var loadingBehavior: Observable<() -> Void> = Observable(value: nil)
    
    var errorBehavior: Observable<(E)> = Observable(value: nil)

    var successObserved = false
    var loadingObserved = false
    var errorObserved = false
    
    var verifyCanMakeRequest: Observable<Any> = Observable(value: nil)
    
    var fetchSourceBehavior: () -> Void = {}
    
    init() {
        observerRequest()
    }
    
    @discardableResult
    func successObserver(_ success: @escaping (T) -> Void) -> ViewState {
        
        self.successBehavior.addObserver(self) { data in
            success(data)
        }
        
        self.successObserved = true
        self.verifyMakeRequest()
                
        return self
    }
    
    @discardableResult
    func loadingObserver(_ loading: @escaping () -> Void) -> ViewState {
        self.loadingBehavior.addObserver(self) { _ in
            loading()
        }
        
        self.loadingObserved = true
        self.verifyMakeRequest()
        
        return self
    }
    
    @discardableResult
    func errorObserver(_ error: @escaping (E) -> Void) -> ViewState {
        self.errorBehavior.addObserver(self) { aferror in
            error(aferror)
        }
        
        self.errorObserved = true
        self.verifyMakeRequest()
        
        return self
    }
    
    func fetchSource(_ request: @escaping () -> Void) {
        self.fetchSourceBehavior = request
    }
    
    func postRequest() {
        self.verifyCanMakeRequest.value = (Any).self
    }
    
    func observerRequest() {
        self.verifyCanMakeRequest.addObserver(self) { _ in
            self.loading()
            self.fetchSourceBehavior()
        }
    }
    
    func success(data: T) {
        self.successBehavior.value = data
    }
    
    func loading() {
        self.loadingBehavior.value = {}
    }
    
    func error(error: E) {
        self.errorBehavior.value = error
    }
    
    func onValueChanged(_ value: Any?) {
        //empty
    }
    
    func verifyMakeRequest() {
        if successObserved &&
            loadingObserved &&
            errorObserved {
            
            postRequest()
        }
    }
}
