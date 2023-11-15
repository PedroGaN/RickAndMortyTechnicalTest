//
//  MainScreenPresenter.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 8/11/23.
//

import Foundation

protocol MainScreenPresenterProtocol: BasePresenterProtocol {}

class MainScreenPresenter: BasePresenter<MainScreenViewControllerProtocol, MainWireframeProtocol>,
                           MainScreenPresenterProtocol {

    // MARK: - Initializer

    init(view: MainScreenViewControllerProtocol,
         router: MainWireframeProtocol) {
        super.init(view: view, router: router)
    }

}
