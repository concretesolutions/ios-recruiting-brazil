//
//  SVGImageView.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 20/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit
import WebKit

public class SVGImageView: UIView {
    private let webView = WKWebView()

    public init() {
        super.init(frame: .zero)
        webView.scrollView.isScrollEnabled = false
        webView.contentMode = .scaleAspectFit
        webView.backgroundColor = .clear
        addSubview(webView)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        webView.stopLoading()
    }

    public func load(url: String) {
        webView.stopLoading()
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        }
    }
}

extension SVGImageView: WKUIDelegate {
    public func webViewDidFinishLoad(_ webView: WKWebView) {
        let scaleFactor = webView.bounds.size.width / webView.scrollView.contentSize.width
        if scaleFactor <= 0 {
            return
        }

        webView.scrollView.minimumZoomScale = scaleFactor
        webView.scrollView.maximumZoomScale = scaleFactor
        webView.scrollView.zoomScale = scaleFactor
    }
}
