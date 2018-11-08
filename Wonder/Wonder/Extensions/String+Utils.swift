//
//  String+Utils.swift
//  Wonder
//
//  Created by Marcelo on 08/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

extension String
{
    func removeCharacters(characters: String) -> String
    {
        let characterSet = NSCharacterSet(charactersIn: characters)
        let components = self.components(separatedBy: characterSet as CharacterSet)
        let result = components.joined()
        return result
    }
}
