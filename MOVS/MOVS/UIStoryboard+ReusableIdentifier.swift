//
//  UIStoryboard+ReusableIdentifier.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 16/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyBoardIdentifier) as? T else {
            print("Unable to get viewController of type: \(T.self) in: \(self)")
            fatalError()
        }
        
        return viewController
        
    }
}
