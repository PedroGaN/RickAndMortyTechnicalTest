//
//  FilterCharactersInteractor.swift
//  Domain
//
//  Created by Pedro García Navalón on 20/11/23.
//

import Foundation

public struct FilterCharactersInteractorParameter {

    public let filters: FilterCharactersRequestDomainModel

    public init(_ filters: FilterCharactersRequestDomainModel) {
        self.filters = filters
    }

}

public class FilterCharactersInteractor: BaseInteractor<FilterCharactersInteractorParameter, CharactersDomainModel> {

    // MARK: - Properties

    private let alamofireHttpRepository: HttpRepository

    // MARK: - Initializer

    public init(alamofireHttpRepository: HttpRepository) {
        self.alamofireHttpRepository = alamofireHttpRepository
        super.init()
    }

    // MARK: - Functions

    public override func handle(parameter: FilterCharactersInteractorParameter,
                                onSuccess: @escaping (CharactersDomainModel) -> Void,
                                onFailure: @escaping (Error) -> Void) {

        alamofireHttpRepository.filterCharacters(filters: parameter.filters, onSuccess: { characters in
            onSuccess(characters)
        }, onFailure: { error in
            onFailure(error)
        })
    }

}
