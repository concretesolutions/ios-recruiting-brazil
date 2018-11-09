//
//  DetailActionCell.swift
//  Wonder
//
//  Created by Marcelo on 09/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

class DetailActionCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var shareButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - UI Actions
    
    @IBAction func favoriteAction(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "didChangeFavorite"), object:self)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "didSelectShare"), object:self)
    }
    

}
