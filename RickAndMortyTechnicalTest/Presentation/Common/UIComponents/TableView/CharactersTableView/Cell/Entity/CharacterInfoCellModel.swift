//
//  CharacterInfoCellModel.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 16/11/23.
//

import Foundation

typealias CharacterInfoCellModels = [CharacterInfoCellModel]
struct CharacterInfoCellModel {
    let characterImageURL: String
    let name: String
    let gender: String
    let species: String
    let status: String
    let id: Int
    let type: String
    let origin: String
    let currentLocation: String
}
