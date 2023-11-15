//
//  GenericDataError.swift
//  Data
//
//  Created by Pedro García Navalón on 15/11/23.
//

import Foundation

public enum GenericErrorType {
    case unknown
    case noContent
    case badRequest
    case unauthorized
    case notFound
    case conflict
    case internalServerError
    case serviceUnavailable
    case parseFailed
}

public enum GenericErrorDescription: String {
    case parseFailed = "Error parsing JSON"
    case emptyData = "Error empty data"
    case mockNotFound = "Mock file not found"
}


public class GenericDataError: BaseError<GenericErrorType> {

    public override init(type: GenericErrorType, description: String = "") {
        super.init(type: type, description: description)
    }
}

open class BaseError<ErrorType>: Error {

    public let type: ErrorType
    public let description: String

    public init(type: ErrorType, description: String) {
        self.type = type
        self.description = description
    }

}
