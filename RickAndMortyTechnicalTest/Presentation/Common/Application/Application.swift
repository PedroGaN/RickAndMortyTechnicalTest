//
//  Application.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 7/11/23.
//

import Foundation
import UIKit

final class Application {

    static let shared = Application()

    // MARK: -  Private Properties

    private static var window: UIWindow!

    // MARK: - Initializer

    public init() {}

    // MARK: - Methods

    func configureMainScreen(in window: UIWindow) {

        Application.setWindow(window)

        window.rootViewController = Application.getNavigationController()

        MainWireframe().toSplash()
    }

    public func getNavigationController(rootVC: UIViewController? = nil) -> UINavigationController {
        return Application.getNavigationController()
    }

    public static func setWindow(_ window: UIWindow) {
        self.window = window
    }

    public static func getNavigationController(rootVC: UIViewController? = nil) -> UINavigationController {
        if let rootVC = rootVC {
            return UINavigationController(rootViewController: rootVC)
        } else {
            let navigationController = window.rootViewController as? UINavigationController

            if let navigationController = navigationController {
                return navigationController
            } else {
                return UINavigationController()
            }
        }
    }

}
