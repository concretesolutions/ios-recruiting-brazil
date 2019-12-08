//
//  UIFont+Extensions.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit
import os.log

// Load fonts when first used from bundle root directory
private final class BundleLocator {}
private let fonts: [URL] = {
    
    let bundleURL = Bundle(for: BundleLocator.self).resourceURL!
    let resourceURLs = try? FileManager.default.contentsOfDirectory(at: bundleURL, includingPropertiesForKeys: [], options: .skipsHiddenFiles)
    let fonts = resourceURLs?.filter { $0.pathExtension == "otf" || $0.pathExtension == "ttf" } ?? []

    fonts.forEach { CTFontManagerRegisterFontsForURL($0 as CFURL, CTFontManagerScope.process, nil) }

    return fonts
}()

extension UIFont {
    static func regular(_ size: CGFloat) -> UIFont {
        _ = fonts
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }

    static func bold(_ size: CGFloat) -> UIFont {
        _ = fonts
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }

    static func black(_ size: CGFloat) -> UIFont {
        _ = fonts
        return UIFont.systemFont(ofSize: size, weight: .black)
    }

    @available(iOS 13.0, *)
    static func roundedBold(_ size: CGFloat) -> UIFont {
        _ = fonts
        var font: UIFont
        if let fontDescriptor = UIFont.systemFont(ofSize: size, weight: .bold)
            .fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: fontDescriptor, size: size)
        } else {
            // Fallback on earlier versions
            font = UIFont.systemFont(ofSize: size, weight: .bold)
            os_log("❌ - Could not get default font", log: Logger.appLog(), type: .fault)
        }
        return font
    }

    @available(iOS 13.0, *)
    static func rounded(_ size: CGFloat) -> UIFont {
        _ = fonts
        var font: UIFont
        if let fontDescriptor = UIFont.systemFont(ofSize: size, weight: .regular)
            .fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: fontDescriptor, size: size)
        } else {
            // Fallback on earlier versions
            font = UIFont.systemFont(ofSize: size, weight: .regular)
            os_log("❌ - Could not get default font", log: Logger.appLog(), type: .fault)
        }
        return font
    }

    @available(iOS 13.0, *)
    static func roundedBlack(_ size: CGFloat) -> UIFont {
        _ = fonts
        var font: UIFont
        if let fontDescriptor = UIFont.systemFont(ofSize: size, weight: .black)
            .fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: fontDescriptor, size: size)
        } else {
            // Fallback on earlier versions
            font = UIFont.systemFont(ofSize: size, weight: .black)
            os_log("❌ - Could not get default font", log: Logger.appLog(), type: .fault)
        }
        return font
    }
}
