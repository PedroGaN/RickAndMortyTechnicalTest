//
//  HttpRepository.swift
//  Domain
//
//  Created by Pedro García Navalón on 15/11/23.
//

import Foundation

public protocol HttpRepository {

    func fetchCharacters(pageURL: String?,
                         onSuccess: @escaping (_ success: CharactersDomainModel) -> Void,
                         onFailure: @escaping (_ error: Error) -> Void)

    func filterCharacters(filters: FilterCharactersRequestDomainModel,
                          onSuccess: @escaping (_ success: CharactersDomainModel) -> Void,
                          onFailure: @escaping (_ error: Error) -> Void)
}
