//
//  LaunchScreenAnimationView.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 01/11/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit
import SnapKit
import Lottie

class LaunchScreenAnimationView: UIView {
  
  let clapperboardImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = AssetsManager.getImage(forAsset: .orangeClapperboard)
    return imageView
  }()
  
  let lottieAnimationView: LOTAnimationView = {
    let animation = LOTAnimationView(name: "animation2")
    animation.animationSpeed = 2.5
    return animation
  }()
  
  let appNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
    label.textColor = UIColor.black.withAlphaComponent(0.8)
    label.text = "Movies"
    label.textAlignment = .center
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.whiteAlabaster
    setupViewConfiguration()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

/////////////////////////////////////////
//
// MARK: View configuration
//
/////////////////////////////////////////
extension LaunchScreenAnimationView: ViewConfiguration {
  
  func setupConstraints() {
    clapperboardImageView.snp.makeConstraints { make in
      make.width.height.equalTo(80)
      make.centerX.centerY.equalTo(self)
    }
    
    lottieAnimationView.snp.makeConstraints { (make) in
      make.height.equalTo(self.frame.width / 1.777)
      make.centerY.equalTo(self).offset(40)
      make.left.right.equalTo(self)
    }
    
    appNameLabel.snp.makeConstraints { (make) in
      make.height.equalTo(80)
      make.centerY.left.right.equalTo(self)
    }
    
    layoutIfNeeded()
  }
  
  func buildViewHierarchy() {
    addSubview(lottieAnimationView)
    addSubview(appNameLabel)
    addSubview(clapperboardImageView)
  }
  
}

/////////////////////////////////////////
//
// MARK: Launch screen animation
//
/////////////////////////////////////////
extension LaunchScreenAnimationView {
  
  func startAnimations() {
    clapperboardImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
    appNameLabel.transform = .identity
    appNameLabel.alpha = 1
    clapperboardImageView.snp.updateConstraints { make in
      make.centerY.equalTo(self).offset(-45)
    }
    
    appNameLabel.snp.updateConstraints { make in
      make.centerY.equalTo(self).offset(45)
    }
    
    layoutIfNeeded()
  }
  
  func endAnimations() {
    clapperboardImageView.snp.updateConstraints { make in
      make.centerY.equalTo(self).offset(10)
    }
    
    appNameLabel.snp.updateConstraints { make in
      make.centerY.equalTo(self).offset(10)
    }
    
    appNameLabel.alpha = 0
    clapperboardImageView.alpha = 0
    alpha = 0
    
    layoutIfNeeded()
  }
  
  func animateView(onSuperView superView: UIView, completion: (() -> Void)? = nil) {
    superView.addSubview(self)
    lottieAnimationView.play()
    
    appNameLabel.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
    appNameLabel.alpha = 0
    
    UIView.animate(
      withDuration: 0.5,
      delay: 0.1,
      options: [],
      animations: startAnimations) { _ in
        UIView.animate(withDuration: 0.5,
                       delay: 0.7,
                       options: [],
                       animations: self.endAnimations
        ) { _ in
          self.removeFromSuperview()
          completion?()
        }
    }
  }
  
}
