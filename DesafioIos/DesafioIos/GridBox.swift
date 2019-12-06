
//
//  AnotherScreen .swift
//  viewCode
//
//  Created by Kacio Henrique Couto Batista on 02/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public final class GridBox:UIView{
    lazy var imageView:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .green
        return view
    }()
    lazy var textContainer:UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 8.0
        stack.backgroundColor = .red
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
        
    }()
    lazy var title:UILabel = {
        let view = UILabel(frame: .zero)
        view.backgroundColor = .orange
        return view
    }()
    lazy var subTitle:UILabel = {
          let view = UILabel(frame: .zero)
          view.backgroundColor = .red
          return view
      }()
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupBackground()
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupBackground(){
    }
}
extension GridBox:CodeView{
    func buildViewHierarchy() {
        self.addSubview(imageView)
        self.textContainer.addArrangedSubview(title)
        self.textContainer.addArrangedSubview(subTitle)
        self.addSubview(textContainer)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.7)
            make.top.left.right.equalToSuperview()
        }
        textContainer.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(8.0)
        }
        
    }
    
    func setupAdditionalConfiguration() {
    }
    
    
}
