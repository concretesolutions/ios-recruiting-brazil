//
//  ButtonTableViewCell.swift
//  Movs
//
//  Created by Julio Brazil on 24/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit

public class ToggleButtonTableViewCell: UITableViewCell, CodeView {
    lazy var toggle: ToggleButton = {
        let button = ToggleButton(onImage: UIImage(named: "favorite_full_icon")!, offImage: UIImage(named: "favorite_gray_icon")!)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(toggleValue isOn: Bool = false) {
        super.init(style: .default, reuseIdentifier: nil)
        self.toggle.isOn = isOn
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        self.addSubview(self.toggle)
        self.addSubview(self.label)
    }
    
    func setupConstraints() {
        toggle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: CGFloat(-16)).isActive = true
        toggle.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(16)).isActive = true
        toggle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: CGFloat(-16)).isActive = true
        toggle.widthAnchor.constraint(equalTo: toggle.heightAnchor).isActive = true
        toggle.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(16)).isActive = true
        label.trailingAnchor.constraint(equalTo: toggle.leadingAnchor, constant: CGFloat(-8)).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(8)).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: CGFloat(-8)).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
    }
}
