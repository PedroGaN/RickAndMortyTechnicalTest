//
//  CharactersDataModel.swift
//  Data
//
//  Created by Pedro García Navalón on 16/11/23.
//

import Foundation
import Domain

// MARK: - CharactersDataModel

struct CharactersDataModel: Decodable {

    let info: CharactersInfoDataModel
    let results: [CharactersResultsDataModel]

    enum CodingKeys: String, CodingKey {
        case info
        case results
    }
}

extension CharactersDataModel {

    init(data: Data) throws {
        self = try JSONDecoder().decode(CharactersDataModel.self, from: data)
    }

    // MARK: - Internal functions

    func parseToDomainModel() -> CharactersDomainModel {
        return CharactersDomainModel(info: self.info.parseToDomainModel(), results: self.results.map({ $0.parseToDomainModel() }))
    }
}

// MARK: - CharactersInfoDataModel

struct CharactersInfoDataModel: Decodable {

    let count: Int
    let pages: Int
    let next: String?
    let prev: String?

    enum CodingKeys: String, CodingKey {
        case count
        case pages
        case next
        case prev
    }
}

extension CharactersInfoDataModel {

    init(data: Data) throws {
        self = try JSONDecoder().decode(CharactersInfoDataModel.self, from: data)
    }

    // MARK: - Internal functions

    func parseToDomainModel() -> CharactersInfoDomainModel {
        return CharactersInfoDomainModel(count: self.count, pages: self.pages, next: self.next, prev: self.prev)
    }
}

// MARK: - CharactersResultsDataModel

struct CharactersResultsDataModel: Decodable {

    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: BaseInfoDataModel
    let location: BaseInfoDataModel
    let image: String
    let episode: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case image
        case episode
        case url
        case created
    }
}

extension CharactersResultsDataModel {

    init(data: Data) throws {
        self = try JSONDecoder().decode(CharactersResultsDataModel.self, from: data)
    }

    // MARK: - Internal functions

    func parseToDomainModel() -> CharactersResultsDomainModel {
        return CharactersResultsDomainModel(id: self.id,
                                            name: self.name,
                                            status: self.status,
                                            species: self.species,
                                            type: self.type,
                                            gender: self.gender,
                                            origin: self.origin.parseToDomainModel(),
                                            location: self.location.parseToDomainModel(),
                                            image: self.image,
                                            episode: self.episode,
                                            url: self.url,
                                            created: self.created)
    }
}

// MARK: - BaseInfoDataModel

struct BaseInfoDataModel: Decodable {

    let name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}

extension BaseInfoDataModel {

    init(data: Data) throws {
        self = try JSONDecoder().decode(BaseInfoDataModel.self, from: data)
    }

    // MARK: - Internal functions

    func parseToDomainModel() -> BaseInfoDomainModel {
        return BaseInfoDomainModel(name: self.name, url: self.url)
    }
}
