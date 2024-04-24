//
//  SelfSizingTableView.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 20/11/23.
//

import Foundation
import UIKit

class SelfSizingTableView: UITableView {

    // MARK: - Private Properties

    private var heightConstraint: NSLayoutConstraint?

    // MARK: - LifeCycle

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    deinit {
        removeObserver(self, forKeyPath: "contentSize")
    }

    // MARK: - Private Methods

    private func configure() {
        addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        heightConstraint = NSLayoutConstraint(
            item: self,
            attribute: NSLayoutConstraint.Attribute.height,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: 100)
        if let heightConstraint {
            addConstraint(heightConstraint)
        }
    }

    // MARK: - ObserveValue

    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey: Any]?,
        context: UnsafeMutableRawPointer?) {

        if keyPath == "contentSize" {
            if let newValue = change?[.newKey], let newSize = newValue as? CGSize {
                heightConstraint?.constant = newSize.height
            }
        }
    }

}
