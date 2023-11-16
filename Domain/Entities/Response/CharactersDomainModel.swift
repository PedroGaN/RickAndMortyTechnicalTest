//
//  CharactersDomainModel.swift
//  Domain
//
//  Created by Pedro García Navalón on 16/11/23.
//

import Foundation

// MARK: - CharactersDomainModel

public struct CharactersDomainModel {

    let info: CharactersInfoDomainModel
    let results: [CharactersResultsDomainModel]

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

    let count: Int
    let pages: Int
    let next: String?
    let prev: String?

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

    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: BaseInfoDomainModel
    let location: BaseInfoDomainModel
    let image: String
    let episode: [String]
    let url: String
    let created: String

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

    let name: String
    let url: String

    public init(
        name: String,
        url: String
    ) {
        self.name = name
        self.url = url
    }

}
