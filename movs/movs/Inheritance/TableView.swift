//
//  TableView.swift
//  movs
//
//  Created by Isaac Douglas on 21/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

class TableView: UITableView {
    
    var emptyImage: UIImage?
    var emptyTitle: String?
    var emptySubtitle: String?
    
    override func reloadData() {
        super.reloadData()
        let count = self.numberOfRows(inSection: 0)
        self.empty(count == 0, image: self.emptyImage, title: self.emptyTitle, subtitle: self.emptySubtitle)
    }
    
    internal func empty(_ empty: Bool, image: UIImage?, title: String? = "", subtitle: String? = "") {
        if empty {
            let emptyView = EmptyTableView()
            emptyView.setup(image: image, title: title, subtitle: subtitle)
            self.backgroundView = emptyView
        } else {
            self.backgroundView = UIView()
        }
    }
}
