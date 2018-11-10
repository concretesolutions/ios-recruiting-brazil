//
//  DetailImageCell.swift
//  Wonder
//
//  Created by Marcelo on 09/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

class DetailImageCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailPoster: UIImageView!
    @IBOutlet weak var detailSegueButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - UI Actions
    @IBAction func segueButtonAction(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "didSelectSegue"), object:self)
    }
    

}
