//
//  ListMovsViewController.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 02/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import CommonsModule
import AssertModule

enum ListMovsHandleState {
    case loading
    case success
    case failure(String)
    case tapButton
}

open class ListMovsViewController: BaseViewController {
    
    var presenter: ListMovsPresenter!
    
    var stateUI: ListMovsHandleState = .loading {
        didSet {
            self.stateHandleUI()
        }
    }
    
    let emptySearchView: EmptySearchView = {
        let search = EmptySearchView()
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    let searchBarView: UISearchBar = {
        let view = UISearchBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

}

//MARK: - Lifecycle-
extension ListMovsViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.loading()
        self.view.addSubview(self.searchBarView)
        self.view.addSubview(self.emptySearchView)
        self.searchBarView.delegate = self
        self.setupContraints()
    }
}

//MARK: -State UI-
extension ListMovsViewController {
    private func stateHandleUI() {
        switch self.stateUI {
        case .loading:
            print("Loading")
        case .success:
            print("Success")
        case .failure(let message):
            print("Error in :\(message)")
        case .tapButton:
            print("Tap Button")
        }
        self.presenter.tapOnButton()
    }
    
    @objc func tapOnButton() {
        self.stateUI = .tapButton
    }
}

//MARK: -Action by Presenter-
extension ListMovsViewController: ListMovsView {
    
    func setItemBar(image: UIImage?) {
        self.tabBarItem.image = image
    }
    
    func setTitle(_ text: String) {
        self.title = text
    }
    
    func setItemBar(image: String) {        
        self.tabBarItem.image = UIImage(named: image,
                                        in: Bundle.main,
                                        compatibleWith: nil)
    }
    
    func loadViewController() {
        self.view.backgroundColor = Colors.whiteNormal
    }
}

//MARK: -Setup View-
extension ListMovsViewController {
    func setupContraints() {
        NSLayoutConstraint.activate([
            self.searchBarView.topAnchor.constraint(equalTo: self.topAnchorSafeArea),
            self.searchBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.searchBarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.emptySearchView.topAnchor.constraint(equalTo: self.searchBarView.bottomAnchor),
            self.emptySearchView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.emptySearchView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.emptySearchView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])        
    }
}


//MARK: - UISearchBarDelegate -
extension ListMovsViewController: UISearchBarDelegate {
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print(searchBar.text)
    }
}
