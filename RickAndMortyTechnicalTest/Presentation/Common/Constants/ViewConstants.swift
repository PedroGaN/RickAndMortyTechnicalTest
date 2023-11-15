//
//  ViewConstants.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 7/11/23.
//

import Foundation
import UIKit

struct ViewContants {

    // MARK: - FONTS

    struct fonts {
        static let someFont = "Some Font"
    }

    // MARK: - CORNERS

    struct corner {
        static let up: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        static let left: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        static let right: CACornerMask = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        static let down: CACornerMask = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    struct cornerRadius {}

}
