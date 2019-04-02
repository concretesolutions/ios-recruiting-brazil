//
//  Reachability.swift
//  Movs
//
//  Created by Alexandre Papanis on 02/04/19.
//  Copyright © 2019 Papanis. All rights reserved.
//

import SystemConfiguration

public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}

//import Foundation
//import SystemConfiguration
//
//class Reachability {
//    var hostname: String?
//    var isRunning = false
//    var isReachableOnWWAN: Bool
//    var reachability: SCNetworkReachability?
//    var reachabilityFlags = SCNetworkReachabilityFlags()
//    let reachabilitySerialQueue = DispatchQueue(label: "ReachabilityQueue")
//    init(hostname: String) throws {
//        guard let reachability = SCNetworkReachabilityCreateWithName(nil, hostname) else {
//            throw Network.Error.failedToCreateWith(hostname)
//        }
//        self.reachability = reachability
//        self.hostname = hostname
//        isReachableOnWWAN = true
//        try start()
//    }
//    init() throws {
//        var zeroAddress = sockaddr_in()
//        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//        guard let reachability = withUnsafePointer(to: &zeroAddress, {
//            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
//                SCNetworkReachabilityCreateWithAddress(nil, $0)
//            }
//        }) else {
//            throw Network.Error.failedToInitializeWith(zeroAddress)
//        }
//        self.reachability = reachability
//        isReachableOnWWAN = true
//        try start()
//    }
//    var status: Network.Status {
//        return  !isConnectedToNetwork ? .unreachable :
//            isReachableViaWiFi    ? .wifi :
//            isRunningOnDevice     ? .wwan : .unreachable
//    }
//    var isRunningOnDevice: Bool = {
//        #if targetEnvironment(simulator)
//        return false
//        #else
//        return true
//        #endif
//    }()
//    deinit { stop() }
//
//    static func isConnected() -> Bool {
//        do {
//            try Network.reachability = Reachability(hostname: Defines.baseURL)
//        }
//        catch {
//            switch error as? Network.Error {
//            case let .failedToCreateWith(hostname)?:
//                print("Network error:\nFailed to create reachability object With host named:", hostname)
//                return false
//            case let .failedToInitializeWith(address)?:
//                print("Network error:\nFailed to initialize reachability object With address:", address)
//                return false
//            case .failedToSetCallout?:
//                print("Network error:\nFailed to set callout")
//                return false
//            case .failedToSetDispatchQueue?:
//                print("Network error:\nFailed to set DispatchQueue")
//                return false
//            case .none:
//                print(error)
//                return false
//            }
//        }
//        return true
//    }
//
//}
//
//extension Reachability {
//
//    func start() throws {
//        guard let reachability = reachability, !isRunning else { return }
//        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
//        context.info = Unmanaged<Reachability>.passUnretained(self).toOpaque()
//        guard SCNetworkReachabilitySetCallback(reachability, callout, &context) else { stop()
//            throw Network.Error.failedToSetCallout
//        }
//        guard SCNetworkReachabilitySetDispatchQueue(reachability, reachabilitySerialQueue) else { stop()
//            throw Network.Error.failedToSetDispatchQueue
//        }
//        reachabilitySerialQueue.async { self.flagsChanged() }
//        isRunning = true
//    }
//
//    func stop() {
//        defer { isRunning = false }
//        guard let reachability = reachability else { return }
//        SCNetworkReachabilitySetCallback(reachability, nil, nil)
//        SCNetworkReachabilitySetDispatchQueue(reachability, nil)
//        self.reachability = nil
//    }
//
//    var isConnectedToNetwork: Bool {
//        return isReachable &&
//            !isConnectionRequiredAndTransientConnection &&
//            !(isRunningOnDevice && isWWAN && !isReachableOnWWAN)
//    }
//
//    var isReachableViaWiFi: Bool {
//        return isReachable && isRunningOnDevice && !isWWAN
//    }
//
//    /// Flags that indicate the reachability of a network node name or address, including whether a connection is required, and whether some user intervention might be required when establishing a connection.
//    var flags: SCNetworkReachabilityFlags? {
//        guard let reachability = reachability else { return nil }
//        var flags = SCNetworkReachabilityFlags()
//        return withUnsafeMutablePointer(to: &flags) {
//            SCNetworkReachabilityGetFlags(reachability, UnsafeMutablePointer($0))
//            } ? flags : nil
//    }
//
//    /// compares the current flags with the previous flags and if changed posts a flagsChanged notification
//    func flagsChanged() {
//        guard let flags = flags, flags != reachabilityFlags else { return }
//        reachabilityFlags = flags
//        NotificationCenter.default.post(name: .flagsChanged, object: self)
//    }
//
//    /// The specified node name or address can be reached via a transient connection, such as PPP.
//    var transientConnection: Bool { return flags?.contains(.transientConnection) == true }
//
//    /// The specified node name or address can be reached using the current network configuration.
//    var isReachable: Bool { return flags?.contains(.reachable) == true }
//
//    /// The specified node name or address can be reached using the current network configuration, but a connection must first be established. If this flag is set, the kSCNetworkReachabilityFlagsConnectionOnTraffic flag, kSCNetworkReachabilityFlagsConnectionOnDemand flag, or kSCNetworkReachabilityFlagsIsWWAN flag is also typically set to indicate the type of connection required. If the user must manually make the connection, the kSCNetworkReachabilityFlagsInterventionRequired flag is also set.
//    var connectionRequired: Bool { return flags?.contains(.connectionRequired) == true }
//
//    /// The specified node name or address can be reached using the current network configuration, but a connection must first be established. Any traffic directed to the specified name or address will initiate the connection.
//    var connectionOnTraffic: Bool { return flags?.contains(.connectionOnTraffic) == true }
//
//    /// The specified node name or address can be reached using the current network configuration, but a connection must first be established.
//    var interventionRequired: Bool { return flags?.contains(.interventionRequired) == true }
//
//    /// The specified node name or address can be reached using the current network configuration, but a connection must first be established. The connection will be established "On Demand" by the CFSocketStream programming interface (see CFStream Socket Additions for information on this). Other functions will not establish the connection.
//    var connectionOnDemand: Bool { return flags?.contains(.connectionOnDemand) == true }
//
//    /// The specified node name or address is one that is associated with a network interface on the current system.
//    var isLocalAddress: Bool { return flags?.contains(.isLocalAddress) == true }
//
//    /// Network traffic to the specified node name or address will not go through a gateway, but is routed directly to one of the interfaces in the system.
//    var isDirect: Bool { return flags?.contains(.isDirect) == true }
//
//    /// The specified node name or address can be reached via a cellular connection, such as EDGE or GPRS.
//    var isWWAN: Bool { return flags?.contains(.isWWAN) == true }
//
//    /// The specified node name or address can be reached using the current network configuration, but a connection must first be established. If this flag is set
//    /// The specified node name or address can be reached via a transient connection, such as PPP.
//    var isConnectionRequiredAndTransientConnection: Bool {
//        return (flags?.intersection([.connectionRequired, .transientConnection]) == [.connectionRequired, .transientConnection]) == true
//    }
//
//
//}
//
//func callout(reachability: SCNetworkReachability, flags: SCNetworkReachabilityFlags, info: UnsafeMutableRawPointer?) {
//    guard let info = info else { return }
//    DispatchQueue.main.async {
//        Unmanaged<Reachability>
//            .fromOpaque(info)
//            .takeUnretainedValue()
//            .flagsChanged()
//    }
//}
//
//struct Network {
//    static var reachability: Reachability!
//    enum Status: String {
//        case unreachable, wifi, wwan
//    }
//    enum Error: Swift.Error {
//        case failedToSetCallout
//        case failedToSetDispatchQueue
//        case failedToCreateWith(String)
//        case failedToInitializeWith(sockaddr_in)
//    }
//}
//
//extension Notification.Name {
//    static let flagsChanged = Notification.Name("FlagsChanged")
//}
