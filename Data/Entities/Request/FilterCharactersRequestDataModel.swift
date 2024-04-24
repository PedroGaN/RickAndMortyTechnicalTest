//
//  FilterCharactersRequestDataModel.swift
//  Data
//
//  Created by Pedro García Navalón on 20/11/23.
//

import Foundation
import Domain

struct FilterCharactersRequestDataModel: Encodable {

    let name: String?
    let status: String?
    let species: String?
    let gender: String?

    init(_ model: FilterCharactersRequestDomainModel) {
        name = model.name
        status = model.status
        species = model.species
        gender = model.gender
    }

}
