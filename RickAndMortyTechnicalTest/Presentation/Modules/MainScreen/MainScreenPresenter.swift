//
//  MainScreenPresenter.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 8/11/23.
//

import Foundation
import Domain

protocol MainScreenPresenterProtocol: BasePresenterProtocol {
    func handleFetchData(for type: Constants.FetchType)
    func handleFilterCharacters(for filters: FilterCharactersModel)
}

class MainScreenPresenter: BasePresenter<MainScreenViewControllerProtocol, MainWireframeProtocol>,
                           MainScreenPresenterProtocol {

    // MARK: - Private Properties

    private let fetchCharactersInteractor: FetchCharactersInteractor
    private let filterCharactersInteractor: FilterCharactersInteractor
    /// Limited fetch
    private var fetchCharactersIterations: Int = .zero
    private var filterCharactersIterations: Int = .zero

    private var characters: [CharactersResultsDomainModel]?
    private var filteredCharacters: [CharactersResultsDomainModel]?
    private var downloadedCharacterImages: Bool = false

    // MARK: - Initializer

    init(view: MainScreenViewControllerProtocol,
         router: MainWireframeProtocol,
         fetchCharactersInteractor: FetchCharactersInteractor,
         filterCharactersInteractor: FilterCharactersInteractor) {
        self.fetchCharactersInteractor = fetchCharactersInteractor
        self.filterCharactersInteractor = filterCharactersInteractor
        super.init(view: view, router: router)
    }

    // MARK: - Private Methods

    override func didLoad() {
        handleFetchData(for: .characters)
    }

    private func handleFetchCharacters(forPage pageURL: String? = nil) {
        if let characters,
           fetchCharactersIterations > 3 {
            hideLoading()
            getView()?.setTableCharactersInfo(getCharacterModels(characters))
        } else {
            fetchCharactersInteractor.execute(pageURL, onSuccess: { [weak self] characters in
                self?.setCharacters(characters.results)
                /// Limited fetch
                self?.fetchCharactersIterations += 1
                if let nextPageURL = characters.info.next,
                   /// Limited fetch
                   self?.fetchCharactersIterations ?? .zero <= 3 {
                    self?.handleFetchCharacters(forPage: nextPageURL)
                } else {
                    self?.getView()?.setTableCharactersInfo(self?.getCharacterModels(self?.characters))
                    self?.hideLoading()
                }
            }, onFailure: { [weak self] error in
                self?.hideLoading()
                self?.view?.showBasicDialog(text: "error_service".localized, message: nil)
            }).disposed(by: self.disposeBag)
        }
    }

    private func handleFilterCharacters(_ filters: FilterCharactersRequestDomainModel) {
        let parameter = FilterCharactersInteractorParameter(filters)
        filterCharactersInteractor.execute(parameter, onSuccess: { [weak self] characters in
            self?.setFilteredCharacters(characters.results)
            /// Limited fetch
            self?.filterCharactersIterations += 1
            if let nextPageURL = characters.info.next,
               /// Limited fetch
               self?.filterCharactersIterations ?? .zero <= 3 {
                self?.handleFilterCharacters(FilterCharactersRequestDomainModel(pageURL: nextPageURL))
            } else {
                self?.filterCharactersIterations = .zero
                self?.getView()?.setTableCharactersInfo(self?.getCharacterModels(self?.filteredCharacters))
                self?.hideLoading()
            }
        }, onFailure: { [weak self] error in
            self?.hideLoading()
            self?.view?.showBasicDialog(text: "error_service".localized, message: nil)
        }).disposed(by: self.disposeBag)
    }

    private func setCharacters(_ charactersInfo: [CharactersResultsDomainModel]) {
        if var characters {
            characters.append(contentsOf: charactersInfo)
        } else {
            characters = charactersInfo
        }
    }

    private func setFilteredCharacters(_ filteredCharactersInfo: [CharactersResultsDomainModel]) {
        if var filteredCharacters {
            filteredCharacters.append(contentsOf: filteredCharactersInfo)
        } else {
            filteredCharacters = filteredCharactersInfo
        }
    }

    private func getCharacterModels(_ characters: [CharactersResultsDomainModel]?) -> CharacterInfoCellModels {
        var characterModel: CharacterInfoCellModels = []
        if let characters {
            characters.forEach { character in
                characterModel.append(
                    CharacterInfoCellModel(
                        characterImageURL: character.image,
                        name: character.name,
                        gender: character.gender,
                        species: character.species,
                        status: character.status,
                        id: character.id,
                        type: character.type,
                        origin: character.origin.name,
                        currentLocation: character.location.name
                    )
                )
            }
        }
        return characterModel
    }

    // MARK: - Protocol

    func handleFetchData(for type: Constants.FetchType) {
        showLoading()
        switch type {
        case .characters:
            handleFetchCharacters()
        case .locations: print("Locations")
        case .episodes: print("Episodes")
        }
    }

    func handleFilterCharacters(for filters: FilterCharactersModel) {
        showLoading()
        handleFilterCharacters(
            FilterCharactersRequestDomainModel(
                name: filters.name,
                status: filters.status,
                species: filters.species,
                gender: filters.gender
            )
        )
    }

}
