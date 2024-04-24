//
//  Constants.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 7/11/23.
//

import Foundation

struct Constants {

    enum FetchType: Int {
        case characters = 0
        case locations = 1
        case episodes = 2
    }

    public enum StatusFilterType: String {
        case alive = "alive"
        case dead = "dead"
        case unknown = "unknown"
    }

    public enum GenderFilterType: String {
        case female = "female"
        case male = "male"
        case genderless = "genderless"
        case unknown = "unknown"
    }

}
