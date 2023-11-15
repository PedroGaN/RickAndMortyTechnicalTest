//
//  UIView.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 7/11/23.
//

import Foundation
import UIKit

extension UIView {

    public static var identifier: String {
        return String(describing: self)
    }

    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    public func setCorners(corners: CACornerMask? = nil,
                           radius: CGFloat? = nil) {
        if let corners = corners {
            layer.maskedCorners = corners
        }

        if let radius = radius {
            layer.cornerRadius = radius
        } else {
            layer.cornerRadius = layer.frame.height / 2
        }
    }

    public func setBorder(borderColor: UIColor, borderWidth: CGFloat = 1.0) {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }

    public enum ConstraintType {
        case container
        case center
    }

    public func addSubview(childView: UIView, constraintType: ConstraintType = .container) {
        addSubview(childView)
        childView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = constraintType == .container ? Utils.getContainerConstraints(item: childView, toItem: self)
                                                       : Utils.getCenterConstraints(item: childView, toItem: self)
        addConstraints(constraints)
    }

    public func toggleVisibility() {
        isHidden.toggle()
    }

}
