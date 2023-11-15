//
//  MainWireframe.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 7/11/23.
//

import Foundation
import UIKit

protocol MainWireframeProtocol: BaseWireframeProtocol {
    func toSplash()
    func toMainScreen()
}

class MainWireframe: BaseWireframe, MainWireframeProtocol {

    func toSplash() {
        if var view = getViewFromStoryboard(name: SplashViewController.identifier) as? SplashViewController {
            super.push(view: view)
            let presenter = DependencyInjector.shared.getSplashPresenter(view: view, router: self)
            view.bind(to: presenter)
        }
    }

    func toMainScreen() {
        if var view = getViewFromStoryboard(name: MainScreenViewController.identifier) as? MainScreenViewController {
            let presenter = DependencyInjector.shared.getMainScreenPresenter(view: view, router: self)
            view.bind(to: presenter)
            super.pushRoot(view: view, animated: false)
        }
    }

}
