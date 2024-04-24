//
//  CharactersDomainModel.swift
//  Domain
//
//  Created by Pedro García Navalón on 16/11/23.
//

import Foundation

// MARK: - CharactersDomainModel

public struct CharactersDomainModel {

    public let info: CharactersInfoDomainModel
    public let results: [CharactersResultsDomainModel]

    public init(
        info: CharactersInfoDomainModel,
        results: [CharactersResultsDomainModel]
    ) {
        self.info = info
        self.results = results
    }

}

// MARK: - CharactersInfoDomainModel

public struct CharactersInfoDomainModel {

    public let count: Int
    public let pages: Int
    public let next: String?
    public let prev: String?

    public init(
        count: Int,
        pages: Int,
        next: String?,
        prev: String?
    ) {
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
    }

}

// MARK: - CharactersResultsDomainModel

public struct CharactersResultsDomainModel {

    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let origin: BaseInfoDomainModel
    public let location: BaseInfoDomainModel
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String

    public init(
        id: Int,
        name: String,
        status: String,
        species: String,
        type: String,
        gender: String,
        origin: BaseInfoDomainModel,
        location: BaseInfoDomainModel,
        image: String,
        episode: [String],
        url: String,
        created: String
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }

}

// MARK: - BaseInfoDomainModel

public struct BaseInfoDomainModel {

    public let name: String
    public let url: String

    public init(
        name: String,
        url: String
    ) {
        self.name = name
        self.url = url
    }

}
