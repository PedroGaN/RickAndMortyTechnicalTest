//
//  NetworkConstants.swift
//  Data
//
//  Created by Pedro García Navalón on 15/11/23.
//

import Foundation

struct NetworkConstants {

    enum HTTPcode: Int {
        case unknown = 0
        case ok = 200
        case noContent = 204
        case badRequest = 400
        case unauthorized = 401
        case notFound = 404
        case conflict = 409
        case internalServerError = 500
        case serviceUnavailable = 503
    }

    struct HTTPRanges {
        static let success = 200...299
        static let clientError = 400...499
        static let serverError = 500...599
    }

    struct Configuration {
        #if DEVELOPMENT
        static let requestTimeout = 60.0
        static let resourceTimeout = 60.0
        #else
        static let requestTimeout = 10.0
        static let resourceTimeout = 10.0
        #endif
    }

}
