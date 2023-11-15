//
//  UINavigationController.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 7/11/23.
//

import Foundation
import UIKit

extension UINavigationController {

    func pushRootViewController(animated: Bool) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }

        window.rootViewController = self

        if animated {
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }

}
