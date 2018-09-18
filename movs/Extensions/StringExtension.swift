//
//  StringExtension.swift
//  movs
//
//  Created by Renan Oliveira on 17/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

extension String {
    func toImageUrl() -> URL? {
        return URL(string: BaseService.BaseURL.image.rawValue + self)
    }
}
