//
//  UITableView+Extension.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 19/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import UIKit

extension UITableView {
    public func addEmptyState(state: EmptyState) {
        DispatchQueue.main.async {
            let emptyView = EmptyView.init()
            emptyView.changeEmptyView(toState: state)
            self.backgroundView = emptyView
        }
    }
}
