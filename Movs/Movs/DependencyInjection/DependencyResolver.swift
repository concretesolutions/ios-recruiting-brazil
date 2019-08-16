//
//  DependencyResolver.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 15/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation
import Swinject

public class DependencyResolver {

    // MARK: - Class properties

    public static let shared = DependencyResolver()

    // MARK: - Public properties

    public let container: Container

    // MARK: - Initialization

    private init() {
        container = Container()
    }

    public func resolve<Service>(_ serviceType: Service.Type) -> Service {
        return container.resolve(serviceType)
    }

    public func tryResolve<Service>(_ serviceType: Service.Type) -> Service? {
        return container.resolve(serviceType)
    }

    public func resolve<Service, Arg>(_ serviceType: Service.Type, argument: Arg) -> Service {
        return container.resolve(serviceType, argument: argument)
    }

    //swiftlint:disable function_parameter_count
    public func resolve<Service, Arg1, Arg2>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2) -> Service {
        return container.resolve(serviceType, arguments: arg1, arg2)
    }

    public func resolve<Service, Arg1, Arg2, Arg3>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> Service {
        return container.resolve(serviceType, arguments: arg1, arg2, arg3)
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> Service {
        return container.resolve(serviceType, arguments: arg1, arg2, arg3, arg4)
    }

    public func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> Service {
        return container.resolve(serviceType, arguments: arg1, arg2, arg3, arg4, arg5)
    }
    //swiftlint:enable function_parameter_count

    public func resolve<Service>(_ serviceType: Service.Type, name: String) -> Service {
        return container.resolve(serviceType, name: name)
    }

    public func resolve<Service, Arg1>(_ serviceType: Service.Type, name: String?, argument: Arg1) -> Service {
        return container.resolve(serviceType, name: name, argument: argument)
    }
}
