//
//  JSONHelper.swift
//  MovsTests
//
//  Created by Joao Lucas on 08/10/20.
//

import Foundation

enum JSONHelper {
    
    private class BundleTestClass {}

    public static func loadJSON<Element: Decodable>(withFile fileName: String) -> Element? {
        var jsonData: Element?
        if let url = Bundle(for: BundleTestClass.self).url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                jsonData = try decoder.decode(Element.self, from: data)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        return jsonData
    }

    public static func loadJSONData(withFile fileName: String) -> Data? {
        var data: Data?
        if let url = Bundle(for: BundleTestClass.self).url(forResource: fileName, withExtension: "json") {
            do {
                data = try Data(contentsOf: url)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        return data
    }
}
