//
//  SearchController.swift
//  Movs
//
//  Created by Lucca Ferreira on 10/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit
import Combine

class SearchController: UISearchController {

    @Published var termPublisher: String = ""
    private var textCancellable: AnyCancellable?
    
    required init(withPlaceholder placeholder: String) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = self
        self.searchBar.placeholder = placeholder
        self.obscuresBackgroundDuringPresentation = false
        self.textCancellable = NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self.searchBar.searchTextField)
            .map { (notification) -> String in
                guard let textField = notification.object as? UITextField else { return "" }
                return textField.text!
            }
            .assign(to: \.termPublisher, on: self)
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SearchController: UISearchControllerDelegate {
    
    func willDismissSearchController(_ searchController: UISearchController) {
        self.termPublisher = ""
    }
    
}
