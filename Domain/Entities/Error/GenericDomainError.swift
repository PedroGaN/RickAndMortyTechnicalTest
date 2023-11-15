//
//  GenericDomainError.swift
//  Domain
//
//  Created by Pedro García Navalón on 15/11/23.
//

import Foundation

public enum ErrorDomainType {
    case parse
    case fileNotFound
    case unknown
}

public struct GenericDomainError: Error {

    public let type: ErrorDomainType
    public let description: String

    public init(type: ErrorDomainType = .unknown, description: String = "") {
        self.type = type
        self.description = description
    }

}
