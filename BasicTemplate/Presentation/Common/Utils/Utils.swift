//
//  Utils.swift
//  BasicTemplate
//
//  Created by Pedro García Navalón on 7/11/23.
//

import Foundation
import UIKit

public struct Utils {

    public static func getContainerConstraints(item: NSObject, toItem: NSObject) -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal,
                                               toItem: toItem, attribute: .top,
                                               multiplier: 1, constant: .zero)
        let bottomConstraint = NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal,
                                                  toItem: toItem, attribute: .bottom,
                                                  multiplier: 1, constant: .zero)
        let leadingConstraint = NSLayoutConstraint(item: item, attribute: .leading, relatedBy: .equal,
                                                   toItem: toItem, attribute: .leading,
                                                   multiplier: 1, constant: .zero)
        let trailingConstraint = NSLayoutConstraint(item: item, attribute: .trailing, relatedBy: .equal,
                                                    toItem: toItem, attribute: .trailing,
                                                    multiplier: 1, constant: .zero)

        return [topConstraint, bottomConstraint, leadingConstraint, trailingConstraint]
    }

    public static func getCenterConstraints(item: NSObject, toItem: NSObject) -> [NSLayoutConstraint] {
        let centerHorConstraint = NSLayoutConstraint(item: item, attribute: .centerX, relatedBy: .equal,
                                                     toItem: toItem, attribute: .centerX,
                                                     multiplier: 1, constant: .zero)
        let centerVerConstraint = NSLayoutConstraint(item: item, attribute: .centerY, relatedBy: .equal,
                                                     toItem: toItem, attribute: .centerY,
                                                     multiplier: 1, constant: .zero)

        return [centerHorConstraint, centerVerConstraint]
    }

    public static func getApplicationFont(withSize size: CGFloat) -> UIFont {
        var applicationFont = UIFont.systemFont(ofSize: size)
        UIFont.familyNames.forEach { font in
            if font == ViewContants.fonts.someFont {
                if let fontName = UIFont.fontNames(forFamilyName: font).first,
                   let font = UIFont.init(name: fontName, size: size) {
                    applicationFont = font
                }
            }
        }

        return applicationFont
    }

}
