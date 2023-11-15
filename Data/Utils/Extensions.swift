//
//  Extensions.swift
//  Data
//
//  Created by Pedro García Navalón on 15/11/23.
//

import Foundation

extension Data {

    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }

}

extension Int {

    var errorType: GenericErrorType {
        switch self {
        case NetworkConstants.HTTPcode.badRequest.rawValue: return .badRequest
        case NetworkConstants.HTTPcode.unauthorized.rawValue: return .unauthorized
        case NetworkConstants.HTTPcode.notFound.rawValue: return .notFound
        case NetworkConstants.HTTPcode.conflict.rawValue: return .conflict
        case NetworkConstants.HTTPcode.badRequest.rawValue: return .badRequest
        case NetworkConstants.HTTPcode.internalServerError.rawValue: return .internalServerError
        case NetworkConstants.HTTPcode.serviceUnavailable.rawValue: return .serviceUnavailable
        default: return .unknown
        }
    }

}
