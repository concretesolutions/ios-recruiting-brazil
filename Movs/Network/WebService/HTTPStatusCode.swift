//
//  HTTPStatusCode.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import Foundation

public enum HTTPStatusCode: Int {

    public init(fromStringValue: String) {
        guard let intValue = Int(fromStringValue) else {
            self = .unknown
            return
        }
        self.init(fromRawValue: intValue)
    }

    public init(fromRawValue: Int) {
        self = HTTPStatusCode(rawValue: fromRawValue) ?? .unknown
    }
    
    /* ---- 1 Informational ---- */
    
    // 100 Continue
    case `continue` = 100
    
    // 101 Switching Protocols
    case switchingProtocols = 101

    // 102 Processing (WebDAV; RFC 2518).
    case processing = 102

    // 103 Early Hints (RFC 8297).
    case earlyHints = 103

    /* ---- Success ---- */

    // 200 OK
    case ok = 200

    // 201 Created
    case created = 201

    // 202 Accepted
    case accepted = 202

    // 203 Non-Authoritative Information (since Http/1.1)
    case nonAuthoritativeInformation = 203

    // 204 No Content
    case noContent = 204

    // 205 Reset Content
    case resetContent = 205

    // 206 Partial Content
    case partialContent = 206

    // 207 Multi-Status (WebDAV; RFC 4918)
    case multiStatus = 207

    // 208 Already Reported (WebDAV; RFC 5842)
    case alreadyReported = 208

    // 226 IM Used (RFC 3229)
    case iMUsed = 226

    // 250 Low on Storage Space (RTSP; RFC 2326)
    case lowOnStorageSpace = 250

    /* ---- 3 Redirection ---- */

    // 300 Multiple Choices
    case multipleChoices = 300
    
    // 301 Moved Permanently
    case movedPermanently = 301

    // 302 Found
    case found = 302

    // 303 See Other (since Http/1.1)
    case seeOther = 303

    // 304 Not Modified
    case notModified = 304

    // 305 Use Proxy (since Http/1.1)
    case useProxy = 305

    // 306 Switch Proxy
    case switchProxy = 306

    // 307 Temporary Redirect (since Http/1.1)
    case temporaryRedirect = 307

    // 308 Permanent Redirect (approved as experimental RFC)
    case permanentRedirect = 308

    /* ---- 4 Client Errors ---- */

    // 400 Bad Request
    case badRequest = 400
    
    // 401 Unauthorized
    case unauthorized = 401

    // 402 Payment Required
    case paymentRequired = 402

    // 403 Forbidden
    case forbidden = 403

    // 404 Not Found
    case notFound = 404

    // 405 Method Not Allowed
    case methodNotAllowed = 405

    // 406 Not Acceptable
    case notAcceptable = 406

    // 407 Proxy Authentication Required
    case proxyAuthenticationRequired = 407

    // 408 Request Timeout
    case requestTimeout = 408

    // 409 Conflict
    case conflict = 409

    // 410 Gone
    case gone = 410

    // 411 Length Required
    case lengthRequired = 411

    // 412 Precondition Failed
    case preconditionFailed = 412

    // 413 Request Entity Too Large
    case requestEntityTooLarge = 413

    // 414 Request-URI Too Long
    case requestURITooLong = 414

    // 415 Unsupported Media Type
    case unsupportedMediaType = 415

    // 416 Requested Range Not Satisfiable
    case requestedRangeNotSatisfiable = 416

    // 417 Expectation Failed
    case expectationFailed = 417

    // 418 I'm a teapot (RFC 2324)
    case imATeapot = 418

    // 421 Misdirected Request (RFC 7540)
    case misdirectedRequest = 421

    // 422 Unprocessable Entity (WebDAV; RFC 4918)
    case unprocessableEntity = 422

    // 423 Locked (WebDAV; RFC 4918)
    case locked = 423

    // 424 Failed Dependency (WebDAV; RFC 4918)
    case failedDependency = 424

    // 426 Upgrade Required (RFC 2817)
    case upgradeRequired = 426

    // 428 Precondition Required (RFC 6585)
    case preconditionRequired = 428

    // 429 Too Many Requests (RFC 6585)
    case tooManyRequests = 429

    // 431 Request Header Fields Too Large (RFC 6585)
    case requestHeaderFieldsTooLarge = 431

    // 451 Unavailable For Legal Reasons (RFC 7725)
    case unavailableForLegalReasons = 451

     /* ---- 5 Server Errors ---- */
 
    // 500 Internal Server Error
    case internalServerError = 500

    // 501 Not Implemented
    case notImplemented = 501

    // 502 Bad Gateway
    case badGateway = 502

    // 503 Service Unavailable
    case serviceUnavailable = 503

    // 504 Gateway Timeout
    case gatewayTimeout = 504

    // 505 Http Version Not Supported
    case httpVersionNotSupported = 505

    // 506 Variant Also Negotiates (RFC 2295)
    case variantAlsoNegotiates = 506

    // 507 Insufficient Storage (WebDAV; RFC 4918)
    case insufficientStorage = 507

    // 508 Loop Detected (WebDAV; RFC 5842)
    case loopDetected = 508

    // 510 Not Extended (RFC 2774)
    case notExtended = 510

    // 511 Network Authentication Required (RFC 6585)
    case networkAuthenticationRequired = 511

    // 598 Network read timeout error (Unknown)
    case networkReadTimeoutError = 598

    // 599 Network connect timeout error (Unknown)
    case networkConnectTimeoutError = 599

    // 1001 Network connect timeout error (iOS)
    case iOSNetworkConnectTimeoutError = -1001

    // 1003 Network connect timeout error (Apple)
    case appleNetworkConnectTimeoutError = -1003

    // 1004 The `baseURL` host cannot be reached or the host reachability is not known. (iOS)
    case iOSNetworkNotReachable = -1004

    // 1009 The `baseURL` host cannot be reached or the host reachability is not known. (Apple)
    case appleNetworkNotReachable = -1009

    // 666 Unknown status code
    case unknown = 666

    // -1 Expired session code returned by the SDK when the session has expired and user tries to make a server call
    case expiredSession = -1
}
