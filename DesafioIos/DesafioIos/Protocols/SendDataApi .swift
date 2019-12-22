//
//  SendDataApi .swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 12/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import Foundation
protocol SendDataApi {
    func sendMovie(movies:[Movie])
    func sendStatus(status:StatusConnection)
}
