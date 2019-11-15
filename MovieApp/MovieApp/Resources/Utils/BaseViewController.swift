//
//  BaseViewController.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//
import UIKit
import Lottie

enum TypeError {
    case failureRequest
    case noInternet
    case notFound
}

class BaseViewController: UIViewController {
    
    let starAnimationView = AnimationView()
    let starAnimation = Animation.named("loading")
    
    let blackUIView: UIView = {
        let blackUIView = UIView(frame: .zero)
        blackUIView.translatesAutoresizingMaskIntoConstraints = false
        blackUIView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        return blackUIView
    }()
    
    
    let redUIView: UIView = {
        let redUIView = UIView(frame: .zero)
        redUIView.translatesAutoresizingMaskIntoConstraints = false
        redUIView.backgroundColor = UIColor(red: 0.999, green: 0.498, blue: 0.009, alpha: 1.0)
        return redUIView
    }()
        
    let viewBackground: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let errorLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.font = UIFont(name: Strings.fontProject, size: 25)
        view.textColor = .black
        view.text = Strings.msgError
        return view
    }()
    
    let descLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.font = UIFont(name: Strings.fontProject, size: 15)
        view.textColor = .black
        return view
    }()
    
    let errorImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = #imageLiteral(resourceName: "icons8-error")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let button: UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.999, green: 0.498, blue: 0.009, alpha: 1.0)
        view.layer.cornerRadius = 15
        view.tintColor = .black
        view.setTitle(Strings.titleButton, for: .normal)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func startAnimating() {
        starAnimationView.isHidden = false
        starAnimationView.animation = starAnimation
        starAnimationView.frame =  CGRect(x: 0, y: 0, width: 100, height: 100)
        starAnimationView.center = self.view.center
        starAnimationView.loopMode = .loop
        starAnimationView.play()
        self.view.addSubview(starAnimationView)
    }
    
    @objc func buttonTapped() {
        self.blackUIView.isHidden = true
        self.viewBackground.isHidden = true
    }
    
    func stopAnimating() {
        starAnimationView.stop()
        starAnimationView.isHidden = true
    }
    
    func dismissError() {
        self.blackUIView.isHidden = true
        self.viewBackground.isHidden = true
    }
    
    func addError(type: TypeError) {
        self.stopAnimating()
        self.blackUIView.isHidden = false
        self.viewBackground.isHidden = false
        
        self.view.addSubview(blackUIView)
        self.blackUIView.addSubview(viewBackground)
        self.viewBackground.addSubview(redUIView)
        self.viewBackground.addSubview(errorLabel)
        self.viewBackground.addSubview(errorImage)
        self.viewBackground.addSubview(descLabel)
        self.viewBackground.addSubview(button)
        
        switch type {
        case .failureRequest:
            self.descLabel.text = Strings.failureToRequest
        case .noInternet:
            self.descLabel.text = Strings.noInternet
        case .notFound:
            self.descLabel.text = Strings.notFound
        }
        
        blackUIView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        blackUIView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        blackUIView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        blackUIView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        viewBackground.centerXAnchor.constraint(equalTo: self.blackUIView.centerXAnchor).isActive = true
        viewBackground.centerYAnchor.constraint(equalTo: self.blackUIView.centerYAnchor).isActive = true
        viewBackground.heightAnchor.constraint(equalToConstant: 300).isActive = true
        viewBackground.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        redUIView.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor).isActive = true
        redUIView.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor).isActive = true
        redUIView.topAnchor.constraint(equalTo: viewBackground.topAnchor).isActive = true
        redUIView.heightAnchor.constraint(equalTo: viewBackground.heightAnchor, multiplier: 0.4).isActive = true
        
        errorImage.centerXAnchor.constraint(equalTo: self.redUIView.centerXAnchor).isActive = true
        errorImage.centerYAnchor.constraint(equalTo: self.redUIView.centerYAnchor).isActive = true
        errorImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        errorImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        errorLabel.topAnchor.constraint(equalTo: self.redUIView.bottomAnchor, constant: 8).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: self.redUIView.leadingAnchor, constant: 8).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: self.redUIView.trailingAnchor, constant: -8).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: self.errorLabel.bottomAnchor, constant: 8).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: self.redUIView.leadingAnchor, constant: 8).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: self.redUIView.trailingAnchor, constant: -8).isActive = true
        
        button.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: -8).isActive = true
        button.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: 8).isActive = true
        button.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -8).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    func showErros(error: NSError) {
        let alert: UIAlertController = UIAlertController(title: "Erro :(", message: error.localizedDescription, preferredStyle: .alert)
        
        let actionOk: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
}

