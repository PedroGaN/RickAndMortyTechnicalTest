//
//  FetchCharactersInteractor.swift
//  Domain
//
//  Created by Pedro García Navalón on 16/11/23.
//

import Foundation

public class FetchCharactersInteractor: BaseInteractor<String?, CharactersDomainModel> {

    // MARK: - Properties

    private let alamofireHttpRepository: HttpRepository

    // MARK: - Initializer

    init(alamofireHttpRepository: HttpRepository) {
        self.alamofireHttpRepository = alamofireHttpRepository
        super.init()
    }

    // MARK: - Functions

    public override func handle(parameter: String?,
                                onSuccess: @escaping (CharactersDomainModel) -> Void,
                                onFailure: @escaping (Error) -> Void) {

        alamofireHttpRepository.fetchCharacters(pageURL: parameter, onSuccess: { characters in
            onSuccess(characters)
        }, onFailure: { error in
            onFailure(error)
        })
    }

}
