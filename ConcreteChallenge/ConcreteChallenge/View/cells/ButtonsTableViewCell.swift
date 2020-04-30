//
//  ButtonsTableViewCell.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 28/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit

class ButtonsTableViewCell: UITableViewCell {
    @IBOutlet weak var buttonView: UIButton!

    private var action: ((_ sender: Any) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(title: String, action: @escaping (_ sender: Any) -> Void) {
        self.buttonView.setTitle(title, for: .normal)
        self.action = action
    }

    @IBAction func buttonAction(_ sender: Any) {
        if let action = self.action {
            action(sender)
        }
    }

}
