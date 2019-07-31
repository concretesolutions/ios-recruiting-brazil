//
//  SearchBarView.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 28/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import UIKit

class SearchBarView: UIView {
    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var searchBarText: UISearchBar!
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("SearchBarView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    // MARK: - Initialization
    override func awakeFromNib() {
        
        self.contentView.backgroundColor = ColorPalette.yellow.uiColor
        
        self.searchBarText.placeholder = "Search"
        let offset = UIOffset(horizontal: (searchBarText.frame.width - 115) / 2, vertical: 0)
        self.searchBarText.setPositionAdjustment(offset, for: .search)
        let textFieldInsideSearchBar = searchBarText.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = ColorPalette.textBlack.uiColor

        self.searchBarText.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: Constraint Adjustments
        if let searchBarText = self.searchBarText {
            self.addConstraints([
                NSLayoutConstraint(item: searchBarText, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 5),
                NSLayoutConstraint(item: searchBarText, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -5),
                NSLayoutConstraint(item: searchBarText, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: searchBarText, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
                
                ])
        }
        
        self.updateConstraints()
    }

}
