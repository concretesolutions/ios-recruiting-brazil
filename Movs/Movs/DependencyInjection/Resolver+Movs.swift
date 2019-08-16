//
//  Resolver+Movs.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 15/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation
import Swinject

extension Resolver {

    public func resolve<Service>(_ serviceType: Service.Type) -> Service {

        if let resolution = resolve(serviceType) {
            return resolution
        }
        fatalError("Service resolution failed")
    }

    public func resolve<Service, Arg1>(_ serviceType: Service.Type, argument: Arg1) -> Service {

        if let resolution = resolve(serviceType, argument: argument) {
            return resolution
        }
        fatalError("Service resolution failed")
    }

    //swiftlint:disable function_parameter_count
    public func resolve<Service, Arg1, Arg2>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2) -> Service {

        if let resolution = resolve(serviceType, arguments: arg1, arg2) {
            return resolution
        }
        fatalError("Service resolution failed")
    }

    public func resolve<Service, Arg1, Arg2, Arg3>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> Service {

        if let resolution = resolve(serviceType, arguments: arg1, arg2, arg3) {
            return resolution
        }
        fatalError("Service resolution failed")
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> Service {

        if let resolution = resolve(serviceType, arguments: arg1, arg2, arg3, arg4) {
            return resolution
        }
        fatalError("Service resolution failed")
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> Service {

        if let resolution = resolve(serviceType, arguments: arg1, arg2, arg3, arg4, arg5) {
            return resolution
        }
        fatalError("Service resolution failed")
    }
    //swiftlint:enable function_parameter_count

    public func resolve<Service>(_ serviceType: Service.Type, name: String) -> Service {
        if let resolution = resolve(serviceType, name: name) {
            return resolution
        }
        fatalError("Service resolution failed")
    }

    public func resolve<Service, Arg1>(_ serviceType: Service.Type, name: String?, argument: Arg1) -> Service {
        if let resolution = resolve(serviceType, name: name, argument: argument) {
            return resolution
        }
        fatalError("Service resolution failed")
    }
}
