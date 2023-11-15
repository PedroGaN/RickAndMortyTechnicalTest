//
//  Bindable.swift
//  BasicTemplate
//
//  Created by Pedro García Navalón on 7/11/23.
//

import Foundation
import UIKit

public protocol Bindable {
    associatedtype ViewModelType

    var presenter: ViewModelType! { get set }
    func setupUI()
}

extension Bindable where Self: UIViewController {

    /**
     Bind the presenter in the UIViewController.
     */
    public mutating func bind(to presenter: Self.ViewModelType) {
        self.presenter = presenter
        loadViewIfNeeded()
        setupUI()
    }

}
