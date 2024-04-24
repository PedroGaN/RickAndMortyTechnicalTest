//
//  FilterCharactersRequestDomainModel.swift
//  Domain
//
//  Created by Pedro García Navalón on 20/11/23.
//

import Foundation

// MARK: - FilterCharactersRequestDomainModel

public struct FilterCharactersRequestDomainModel {
    
    public let pageURL: String?
    public let name: String?
    public let status: String?
    public let species: String?
    public let gender: String?

    public init(
        pageURL: String? = nil,
        name: String? = nil,
        status: String? = nil,
        species: String? = nil,
        gender: String? = nil
    ) {
        self.pageURL = pageURL
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
    }

}
