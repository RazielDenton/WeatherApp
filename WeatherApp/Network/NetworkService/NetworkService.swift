//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Raziel on 04.03.2023.
//

import Alamofire

enum BaseURLType {
    case openweather

    var baseURL: URL {
        switch self {
        case .openweather:
            return URL(string: "https://api.openweathermap.org/data")! // swiftlint:disable:this force_unwrapping
        }
    }

    var apiVersion: String {
        switch self {
        case .openweather:
            return "/2.5"
        }
    }
}

protocol Parser {
    func parse(result: Any) -> Result<Any, CustomError>
}

protocol INetworkService {
    @discardableResult
    func execute(request: IRequest,
                 parser: Parser,
                 completion: @escaping (Result<Any, CustomError>) -> Void) -> DataRequest
}

final class NetworkService: INetworkService {

    // Dependencies
    private let requestInterceptor: RequestInterceptor?
    private let requestModifier: Session.RequestModifier?

    // Properties
    private let type: BaseURLType

    init(type: BaseURLType = .openweather,
         requestInterceptor: RequestInterceptor? = Interceptor(),
         requestModifier: Session.RequestModifier? = nil) {
        self.type = type
        self.requestInterceptor = requestInterceptor
        self.requestModifier = requestModifier
    }

    @discardableResult
    func execute(request: IRequest,
                 parser: Parser,
                 completion: @escaping (Result<Any, CustomError>) -> Void) -> DataRequest {

        let url: URL = type.baseURL.appendingPathComponent(type.apiVersion).appendingPathComponent(request.path)
        let headers: [HTTPHeader] = request.headers.map { key, value in HTTPHeader(name: key, value: value) }
        var parameterEncoding: ParameterEncoding = URLEncoding.default
        switch request.method {
        case .options, .head, .get, .delete:
            parameterEncoding = URLEncoding.default
        case .patch, .post, .put:
            parameterEncoding = JSONEncoding.default
        default: break
        }

        let request: DataRequest = AF.request(url,
                                              method: request.method,
                                              parameters: request.parameters,
                                              encoding: parameterEncoding,
                                              headers: HTTPHeaders(headers),
                                              interceptor: requestInterceptor,
                                              requestModifier: requestModifier)
            .validate(statusCode: 200...299)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let json: Any = try JSONSerialization.jsonObject(with: data)
                        let parsingResult: Result<Any, CustomError> = parser.parse(result: json)
                        completion(parsingResult)
                    } catch {
                        print("Error while decoding response")
                        completion(.failure(.parser))
                    }
                case .failure(let error):
                    let error: CustomError = self.handleError(from: error, data: response.data, statusCode: response.response?.statusCode)
                    completion(.failure(error))
                }
            }

        request.cURLDescription { cURL in
            print(cURL)
        }

        return request
    }

    private func handleError(from error: AFError, data: Data?, statusCode: Int?) -> CustomError {
        if let data: Data = data,
           let errorDescription: String = String(data: data, encoding: String.Encoding.utf8) {
            return .server(.init(errorCode: statusCode, errorDescription: errorDescription))
        } else {
            return .network(error)
        }
    }
}
