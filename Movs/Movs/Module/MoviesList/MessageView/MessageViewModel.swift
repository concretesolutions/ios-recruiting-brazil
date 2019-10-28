//
//  MessageViewModel.swift
//  Movs
//
//  Created by Bruno Barbosa on 28/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

enum MessageType {
    case errorMessage
    case notFoundMessage
    
    func value() -> (imageName: String, messageTxt: String) {
        switch self {
        case .notFoundMessage:
            return (imageName: "not_found", messageTxt: "Your search hasn't found any result.")
        default:
            return (imageName: "error", messageTxt: "An error has ocurred. Please try again.")
        }
    }
}

struct MessageViewModel {
    let image: UIImage?
    let messageTxt: String
    
    init(withImageNamed imageName: String, andMessage messageTxt: String) {
        self.image = UIImage(named: imageName)
        self.messageTxt = messageTxt
    }
    
    init(with messageType: MessageType) {
        self.image = UIImage(named: messageType.value().imageName)
        self.messageTxt = messageType.value().messageTxt
    }
}
