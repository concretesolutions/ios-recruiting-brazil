//
//  EmptyListView.swift
//  Mov
//
//  Created by Allan on 18/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

final class EmptyListView: UIView {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imageViewEmpty: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        backgroundColor = .clear
        
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
    func setup(withTitle title: String, imageName: String){
        lblTitle.text = title
        imageViewEmpty.image = UIImage(named: imageName)
    }
    
}
