//
//  BaseView.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 7/11/23.
//

import Foundation
import UIKit

public class BaseView: UIView {

    // MARK: - Properties

    var view: UIView?

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }

    // MARK: - Functions

    internal func nibSetup() {
        // Overridden function
    }

    internal func setupView(nibName: String) -> UIView? {

        view = loadViewFromNib(nibName: nibName)

        if let view = view {
            addSubview(childView: view)
        }

        return view
    }

    internal func loadViewFromNib(nibName: String) -> UIView? {
        if !nibName.isEmpty {
            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: nibName, bundle: bundle)
            let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView

            return nibView
        } else {
            return nil
        }
    }

}
