//
//  NetworkDelegate.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import Foundation

protocol NetworkDelegate {
    typealias Handler = (NetworkResponse) -> Void
    func resume(handler: @escaping Handler)
}

class NetworkAttempt {

    static let shared = NetworkAttempt()

    private var attempt: Int = 0

    internal var valid: Bool {
        return self.attempt > 1
    }

    init() {
        self.reset()
    }

    internal func consume() {
        self.attempt -= 1
    }

    internal func reset() {
        self.attempt = 3
    }

}

enum Network: NetworkDelegate {
    case get(_ service: NetworkService)
    case post(_ service: NetworkService)
    case put(_ service: NetworkService)
    case delete(_ service: NetworkService)

    private func retry(code: Int, handler: @escaping Handler) {
        if NetworkAttempt.shared.valid {
            self.resume(handler: handler)
        } else {
            NetworkAttempt.shared.reset()
            handler(NetworkResponse.failure(data: Data(), code: code))
        }
    }

    func resume(handler: @escaping Handler) {
        var request: URLRequest!

        switch self {
        case .get(let service):
            request = self.request(service, httpMethod: .get)
        case .post(let service):
            request = self.request(service, httpMethod: .post)
        case .put(let service):
            request = self.request(service, httpMethod: .put)
        case .delete(let service):
            request = self.request(service, httpMethod: .delete)
        }

        URLSession.shared.configuration.timeoutIntervalForRequest = 36000
        URLSession.shared.configuration.timeoutIntervalForResource = 36000
        URLSession.shared.configuration.allowsCellularAccess = true

        if #available(iOS 11.0, *) {
            URLSession.shared.configuration.waitsForConnectivity = true
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async() {

                let response = response as? HTTPURLResponse
                let data = data ?? Data()
                let code = response?.statusCode ?? 0
                let JSON = String(data: data, encoding: String.Encoding.utf8) ?? ""
                Log.shared.show(info: "\(code)")
                Log.shared.show(info: "\(JSON)")
                
                let curl = self.curl(request: request, pretty: true)
                Log.shared.requests.append(curl)
                Log.shared.status.append(code)
                Log.shared.results.append(JSON)
                
                
                if code.isSuccessCode() {
                    NetworkAttempt.shared.reset()
                    handler(NetworkResponse.success(data: data, code: code))
                } else if code.isInternetErrorCode() {
                    NetworkAttempt.shared.consume()
                    self.retry(code: code, handler: handler)
                } else {
                    NetworkAttempt.shared.reset()
                    handler(NetworkResponse.failure(data: data, code: code))
                }
            }
        }

        URLSession.shared.getAllTasks { tasks in
            let contains = tasks.contains(where: {
                $0.originalRequest?.hashValue == task.originalRequest?.hashValue
            })

            if !contains {
                task.resume()
            }
        }
    }

    private func request(_ service: NetworkService, httpMethod: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: service.url)
        request.httpMethod = httpMethod.rawValue

        let parameters = service.parameters ?? [:]
        request = NetworkEncoding().encode(request, with: parameters)

        let curl = self.curl(request: request, pretty: true)
        Log.shared.show(info: curl)

        return request
    }

    private func error(code: Int, data: Data) -> NSError {
        let JSON = data.modelObject() ?? [:]
        let container = CustomError(JSON: JSON)
        let domain = Bundle.main.bundleIdentifier ?? "undefined"
        let message = container?.status_message ?? self.message(code: code)
        let userInfo = [NSLocalizedDescriptionKey : message]
        let error = NSError(domain: domain, code: code, userInfo: userInfo)
        return error
    }

    private func message(code: Int) -> String {
        switch code {
        case 0:
            return "Algo deu errado, verifique sua conexão ou tente novamente."
        case 400:
            return "[400]: Solicitação está incorreta."
        case 401:
            return "[401]: Solicitação não autorizada."
        case 403:
            return "[403]: Solicitação não permitida."
        case 404:
            return "[404]: Solicitação não encontrada."
        case 408, -1001:
            return "O tempo limite da solicitação expirou."
        case 410:
            return "[410]: Solicitação perdida."
        case 501:
            return "[501]: Solicitação não implementada."
        case 503:
            return "[503]: Serviço indisponível no momento."
        case 550:
            return "[550]: Permissão negada."
        default:
            return "[\(code)]: Algo de inesperado aconteceu e isso foi notificado!"
        }
    }

    private func curl(request: URLRequest, pretty: Bool = false) -> String {
        let complement = pretty ? "\\\n" : ""
        let method = "-X \(request.httpMethod ?? "GET") \(complement)"
        let str = request.url?.absoluteString ?? ""
        let url = "\"" + str + "\""
        let body = String(data: request.httpBody ?? Data(), encoding: .utf8) ?? ""
        let data = "-d \"\(body)\" \(complement)"

        var header = ""
        request.allHTTPHeaderFields?.forEach {
            header += "-H \"\($0.key): \($0.value)\" \(complement)"
        }

        let command = "curl " + complement + method + header + data + url

        return command + " | python -mjson.tool"
    }

}
