//
//  FavoriteMovieCellView.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 06/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit

class FavoriteMovieCellView: UITableViewCell {
    let imageMovie:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .red
        view.contentMode = .scaleToFill
        view.image = #imageLiteral(resourceName: "favorite_gray_icon")
        return view
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension FavoriteMovieCellView:CodeView {
    func buildViewHierarchy() {
        self.addSubview(imageMovie)
    }
    
    func setupConstraints() {
        imageMovie.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
    
    
}
