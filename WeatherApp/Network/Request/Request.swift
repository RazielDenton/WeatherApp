//
//  Request.swift
//  WeatherApp
//
//  Created by Raziel on 04.03.2023.
//

import Alamofire

protocol IRequest {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var headers: [String: String] { get }
}

final class Request: IRequest {
    let path: String
    let method: HTTPMethod
    let parameters: [String: Any]
    let headers: [String: String]

    init(path: String,
         method: HTTPMethod = .get,
         parameters: [String: Any] = [:],
         headers: [String: String] = [:]) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
}
