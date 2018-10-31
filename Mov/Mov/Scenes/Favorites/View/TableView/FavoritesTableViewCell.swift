//
//  FavoritesTableViewCell.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    let favoritesUnit = FavoritesUnitView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension FavoritesTableViewCell: ViewCode {
    
    func addView() {
        self.addSubview(self.favoritesUnit)
    }
    
    func addConstraints() {
        self.favoritesUnit.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
