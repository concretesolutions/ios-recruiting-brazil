//
//  DeveloperWebViewController.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 03/11/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit
import WebKit

class DeveloperWebViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    var url = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let destinationUrl = URL(string: url){
            webView.load(URLRequest(url: destinationUrl))
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
