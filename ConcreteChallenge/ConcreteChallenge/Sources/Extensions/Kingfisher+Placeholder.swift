//
//  Kingfisher+Placeholder.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 28/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation
import Kingfisher

extension KingfisherWrapper where Base: KFCrossPlatformImageView {
    @discardableResult
    public func setImage(
        with resource: Resource?,
        placeholder: Placeholder? = UIImage(assets: .placeholder),
        options: KingfisherOptionsInfo? = nil,
        progressBlock: DownloadProgressBlock? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask?
    {
        return setImage(
            with: resource?.convertToSource(),
            placeholder: placeholder,
            options: options,
            progressBlock: progressBlock,
            completionHandler: completionHandler)
    }

    public var indicatorType: IndicatorType {
        get {
            return .activity
        }
    }
}
