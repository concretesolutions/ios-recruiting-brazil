//
//  JSONHelper.swift
//  theMovie-appTests
//
//  Created by Adriel Alves on 16/01/20.
//  Copyright © 2020 adriel. All rights reserved.
//

import Foundation

private class BundleTestClass {}

enum JSONHelper {
    
    public static func loadJSON<Element: Decodable>(withFile fileName: String) -> Element? {
        var jsonData: Element?
        
        
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                jsonData = try JSONSerialization.jsonObject(with: data) as? Element
            }
            catch {
                debugPrint(error.localizedDescription)
            }
        }
        
        return jsonData
    }
    
}
