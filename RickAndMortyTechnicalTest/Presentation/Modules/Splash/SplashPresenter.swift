//
//  SplashPresenter.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 8/11/23.
//

import Foundation

protocol SplashPresenterProtocol: BasePresenterProtocol {}

class SplashPresenter: BasePresenter<SplashViewControllerProtocol, MainWireframeProtocol>,
                       SplashPresenterProtocol {

    // MARK: - Initializer

    init(view: SplashViewControllerProtocol,
         router: MainWireframeProtocol) {
        super.init(view: view, router: router)
    }

    // MARK: - LifeCycle

    override func didAppear() {
        super.didAppear()
        sleep(1)
        getRouter()?.toMainScreen()
    }

}
