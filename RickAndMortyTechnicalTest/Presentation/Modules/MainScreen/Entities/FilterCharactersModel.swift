//
//  FilterCharactersModel.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 20/11/23.
//

import Foundation

struct FilterCharactersModel {

    let name: String?
    let status: String?
    let species: String?
    let gender: String?

    init(
        name: String? = nil,
        status: String? = nil,
        species: String? = nil,
        gender: String? = nil
    ) {
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
    }

}

extension FilterCharactersModel {

    var isEmpty: Bool {
        name.isNilOrEmpty() && status.isNilOrEmpty() && species.isNilOrEmpty() && gender.isNilOrEmpty()
    }

}
