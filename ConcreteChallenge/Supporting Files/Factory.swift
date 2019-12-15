//
//  Factory.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation
import os.log

struct Factory {
    
    static func getViewController(using presenter: Presenter) -> BaseViewController {
        
        switch presenter {
            
        case is DetailPresenter: return DetailVC(presenter: presenter)
        case is FavoritesPresenter: return FavoritesVC(presenter: presenter)
        case is PopularsPresenter: return PopularsVC(presenter: presenter)
            
        default:
            os_log("❌ - Unknown presenter type %@", log: Logger.appLog(), type: .fault, "\(String(describing: presenter))")
            return BaseViewController(presenter: presenter)
        }
    }
}
