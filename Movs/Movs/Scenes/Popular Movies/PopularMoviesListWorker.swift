//
//  PopularMoviesListWorker.swift
//  Movs
//
//  Created by Tiago Chaves on 11/08/19.
//  Copyright (c) 2019 Tiago Chaves. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class PopularMoviesListWorker {
	
	var PopularMoviesListWorker:PopularMoviesListWorkerProtocol
	
	init(_ PopularMoviesListWorker:PopularMoviesListWorkerProtocol) {
		
		self.PopularMoviesListWorker = PopularMoviesListWorker
	}
	
//	func getData(completion:@escaping(ReturnData?,Error?) -> Void) {
//
//		PopularMoviesListWorker.getData { (data: () throws -> ReturnData) in
//
//			do{
//				let returnData = try data()
//				completion(returnData,nil)
//			}catch let error{
//				completion(nil, error)
//			}
//		}
//	}
}

protocol PopularMoviesListWorkerProtocol {
//	func getData(completion:@escaping(() throws -> ReturnData) -> Void)
}
