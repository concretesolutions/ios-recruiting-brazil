//
//  EmptyTableView.swift
//  movs
//
//  Created by Isaac Douglas on 21/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

class EmptyTableView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var emptyTitle: UILabel!
    @IBOutlet weak var emptySubtitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(self.identifier, owner: self, options: nil)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(self.contentView)
    }
    
    func setup(image: UIImage?, title: String?, subtitle: String?) {
        self.emptyImage.image = image
        self.emptyTitle.text = title
        self.emptySubtitle.text = subtitle
    }
}
