//
//  PosterController.swift
//  Wonder
//
//  Created by Marcelo on 10/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit
import WebKit

class PosterController: UIViewController, WKNavigationDelegate {
    
    // MARK: Public Properties
    public var urlParam = String()
    
    
    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityMessage: UILabel!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator(true)
        
        webView.backgroundColor = UIColor.black
        webView.scrollView.backgroundColor = UIColor.black
        self.view.backgroundColor = UIColor.black
 
        // load web view content
        webView?.navigationDelegate = self
        let url = URL(string: urlParam)
        let requestObj = URLRequest(url: url!);
        activityIndicator(true)
        webView.load(requestObj);

    }
    
    // MARK: - WebView Delegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator(false)
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator(false)
        self.dismiss(animated: true, completion: nil)
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        activityIndicator(false)
        self.dismiss(animated: true, completion: nil)
    }
  
    // MARK: - Activity Indicator Helper
    private func activityIndicator(_ show: Bool) {
        activityMessage.isHidden = !show
        activityIndicator.isHidden = !show
        if show {
            activityIndicator.startAnimating()
        }else{
            activityIndicator.stopAnimating()
        }
    }

    
    // MARK: - UI Actions
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Status Bar Helper
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
