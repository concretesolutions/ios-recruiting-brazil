//
//  ExceptionFeedbackView.swift
//  Movs
//
//  Created by Erick Lozano Borges on 23/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit
import Foundation

enum ExceptionType {
    case emptyResult(String)
    case genericError
}

class ExceptionFeedbackView: UIView {

    weak var delegate:ExceptionFeedbackDelegate?

    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame:.zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textColor = Design.colors.dark
        label.textAlignment = .center
        label.backgroundColor = Design.colors.white
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var exeptionType: ExceptionType = .emptyResult("") {
        didSet{
            switch exeptionType {
            case .emptyResult(let searchText):
                imageView.image = UIImage(named: "Empty_Search_Icon")
                label.text = "It looks like there ain't no movies matching your search for \"\(searchText)\". \n Please, try again!"
            case .genericError:
                imageView.image = UIImage(named: "Error_Icon")
                label.text = "Sorry, there was an error. \n Please, try again!"
            }
        }
    }
    
    init(delegate: ExceptionFeedbackDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.handleException(ofType: self.exeptionType)
    }
    
}


extension ExceptionFeedbackView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(imageView)
        self.addSubview(label)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().inset(80)
            make.height.equalTo(imageView.snp.width)
            make.centerY.equalToSuperview().inset(-80)
        }
        
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.right.equalToSuperview().inset(30)
        }
    }
    
    
}
