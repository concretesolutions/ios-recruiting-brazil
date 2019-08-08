//
//  DisplayInformationView.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 08/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation
import UIKit

class DisplayInformationView: UIView {
    //MARK: Outlets
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var viewContent: UIView!
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadXib()
    }
    
    //MARK: Functions
    private func loadXib() {
        
        let nib = UINib(nibName: "DisplayInformationView", bundle: Bundle.main)
        self.viewContent = (nib.instantiate(withOwner: self, options: nil).first as? UIView)
        self.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.viewContent?.frame = self.frame
        if let viewContent = self.viewContent {
            if self.subviews.count == 0 {
                self.addSubview(viewContent)
            }
        }
    }
    
    func fill(description:String, typeReturn:GenericResult.typeReturn) {
        self.descriptionLabel.text = description
        var imageName:String = ""
        switch typeReturn {
        case .error:
            imageName = "error_icon"
        case .success:
            imageName = "search_icon"
        case .warning:
            imageName = "warning_icon"
        }
        
        self.iconImage.image = UIImage(named: imageName)
    }
}
