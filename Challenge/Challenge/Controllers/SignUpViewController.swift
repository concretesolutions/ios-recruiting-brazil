//
//  SignUpViewController.swift
//  Challenge
//
//  Created by Sávio Berdine on 22/10/18.
//  Copyright © 2018 Sávio Berdine. All rights reserved.
//

import UIKit
import WebKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = token {
            let url = URL(string: "https://www.themoviedb.org/authenticate/\(token)")
            webView.load(URLRequest(url: url!))
        }

        // Do any additional setup after loading the view.
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
