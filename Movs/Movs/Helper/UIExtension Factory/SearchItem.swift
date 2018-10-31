//
//  SearchItem.swift
//  Movs
//
//  Created by Maisa on 30/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

class SearchItem: UIBarButtonItem {

    override init() {
        super.init()
        let searchButton = UIButton(type: .custom)
        searchButton.setImage(UIImage(named: "search_icon"), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        searchButton.addTarget(self, action: #selector(self.searchForMovie), for: .touchUpInside)
        self.customView = searchButton
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc private func searchForMovie(){
        print("🐠 search for movie")
    }
}
