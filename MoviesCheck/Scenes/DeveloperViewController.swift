//
//  DeveloperViewController.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 03/11/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

class DeveloperViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var destinarionUrlString = ""
    
    @IBAction func academyPortfolio(_ sender: Any) {
        
        destinarionUrlString = "https://daniellimadf.github.io"
        
        if(UI_USER_INTERFACE_IDIOM() == .pad){
            performSegue(withIdentifier: AppSegues.iPadWeb.rawValue, sender: nil)
        }else{
            performSegue(withIdentifier: AppSegues.iPhoneWeb.rawValue, sender: nil)
        }
        
    }
    
    
    @IBAction func lastBigJob(_ sender: Any) {
        
        destinarionUrlString = "https://scandoctor.com.br"
        
        if(UI_USER_INTERFACE_IDIOM() == .pad){
            performSegue(withIdentifier: AppSegues.iPadWeb.rawValue, sender: nil)
        }else{
            performSegue(withIdentifier: AppSegues.iPhoneWeb.rawValue, sender: nil)
        }
        
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == AppSegues.iPadWeb.rawValue){
            
            let destinationNavigationController = segue.destination as! UINavigationController
            
            if let destinationViewController = destinationNavigationController.viewControllers.first as? DeveloperWebViewController{
                
                destinationViewController.url = destinarionUrlString
                
            }
            
        }
        
        
        if(segue.identifier == AppSegues.iPhoneWeb.rawValue){
            
            let destinationViewController = segue.destination as! DeveloperWebViewController
            
            destinationViewController.url = destinarionUrlString
            
        }
        
    }
    

}
