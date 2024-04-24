//
//  DependencyInjector.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 7/11/23.
//

import Foundation
import Alamofire
import Domain
import Data

final class DependencyInjector {

    static let shared = DependencyInjector()

    func getAlamofireHttpRepository() -> HttpRepository {
        return AlamofireHttpRepository.shared(baseUrl: AlamofireHttpRepositoryConstants.baseURL)
    }

    // MARK: - Interactors

    func getFetchCharactersInteractor() -> FetchCharactersInteractor {
        return FetchCharactersInteractor(alamofireHttpRepository: getAlamofireHttpRepository())
    }

    func getFilterCharactersInteractor() -> FilterCharactersInteractor {
        return FilterCharactersInteractor(alamofireHttpRepository: getAlamofireHttpRepository())
    }

    // MARK: - Presenters

    func getSplashPresenter(view: SplashViewControllerProtocol, router: MainWireframeProtocol) -> SplashPresenterProtocol {
        return SplashPresenter(view: view, router: router)
    }

    func getMainScreenPresenter(view: MainScreenViewControllerProtocol, router: MainWireframeProtocol) -> MainScreenPresenterProtocol {
        return MainScreenPresenter(view: view, router: router,
                                   fetchCharactersInteractor: getFetchCharactersInteractor(),
                                   filterCharactersInteractor: getFilterCharactersInteractor())
    }

}
