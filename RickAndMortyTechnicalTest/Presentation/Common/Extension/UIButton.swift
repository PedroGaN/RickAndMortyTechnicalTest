//
//  UIButton.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 7/11/23.
//

import Foundation
import UIKit

extension UIButton {

    public func disable() {
        alpha = 0.7
        isEnabled = false
    }

    public func enable() {
        alpha = 1
        isEnabled = true
    }


    func setTitle(string: String, size: CGFloat = 12, uppercased: Bool = false, fontColor: UIColor = .black) {
        let font = Utils.getApplicationFont(withSize: size)
        let attributedTitleNormal = NSMutableAttributedString(string: uppercased ? string.uppercased() : string,
                                                              attributes: [.font: font,
                                                                           .foregroundColor: fontColor])
        setAttributedTitle(attributedTitleNormal, for: .normal)
    }

}
