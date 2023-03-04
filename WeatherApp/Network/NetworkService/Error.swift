//
//  Error.swift
//  WeatherApp
//
//  Created by Raziel on 04.03.2023.
//

import Alamofire

enum CustomError: LocalizedError {
    case network(AFError)
    case parser
    case server(ServerError)
    case unidentified

    var isNotConnectedToInternet: Bool {
        switch self {
        case .network(let afError):
            switch afError {
            case .sessionTaskFailed(let error):
                return (error as? URLError)?.code == .notConnectedToInternet
            default:
                return false
            }
        case .parser,
                .server,
                .unidentified:
            return false
        }
    }

    var isCancelled: Bool {
        switch self {
        case .network(let afError):
            switch afError {
            case .sessionTaskFailed(let error):
                return (error as? URLError)?.code == .cancelled
            default:
                return false
            }
        case .parser,
                .server,
                .unidentified:
            return false
        }
    }

    // MARK: - LocalizedError

    var errorDescription: String? {
        switch self {
        case .network(let afError):
            return afError.underlyingError?.localizedDescription
        case .parser,
                .unidentified:
            return ""
        case .server(let error):
            return error.errorDescription
        }
    }
}

struct ServerError: LocalizedError {
    let errorCode: Int?
    let errorDescription: String?
}
