//
//  YearGenreFilterView.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 20/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import Stevia

class YearGenreFilterView: UIView {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    let yearFilterPickerView = UIPickerView()
    let genresFilterPickerView = UIPickerView()

    let doneButton = UIButton(type: .custom)
    let doneBarButtonItem = UIBarButtonItem()
    
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        renderSuperView()
        renderLayout()
        renderStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        renderSuperView()
        renderLayout()
        renderStyle()
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    
    private let yearFilterTitleLabel = UILabel()
    private let genresFilterTitleLabel = UILabel()
    
    // Private Methods
    
    private func renderSuperView() {
        sv(
            yearFilterTitleLabel,
            yearFilterPickerView,
            genresFilterTitleLabel,
            genresFilterPickerView
        )
    }
    
    private func renderLayout() {
        yearFilterTitleLabel.left(16).right(16).Top + 16 == safeAreaLayoutGuide.Top
        yearFilterPickerView.left(0).right(0).height(120).Top + 8 == yearFilterTitleLabel.Bottom
        
        genresFilterTitleLabel.left(16).right(16).Top + 16 == yearFilterPickerView.Bottom
        genresFilterPickerView.left(0).right(0).height(120).Top + 8 == genresFilterTitleLabel.Bottom
        
        layoutIfNeeded()
    }
    
    private func renderStyle() {
        style { (s) in
            s.backgroundColor = .mvBackground
        }
        yearFilterTitleLabel.style { (s) in
            s.font = UIFont.systemFont(ofSize: 34, weight: .regular)
            s.textColor = .mvText
            s.text = "Year"
        }
        genresFilterTitleLabel.style { (s) in
            s.font = UIFont.systemFont(ofSize: 34, weight: .regular)
            s.textColor = .mvText
            s.text = "Genre"
        }
        doneButton.style { (s) in
            s.setTitleColor(.mvYellow, for: .normal)
            s.setTitle("Done", for: .normal)
        }
        doneBarButtonItem.style { (s) in
            s.customView = doneButton
            s.tintColor = .mvYellow
        }
    }
}
