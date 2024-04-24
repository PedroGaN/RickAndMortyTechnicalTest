//
//  UITextField.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 7/11/23.
//

import Foundation
import UIKit

extension UITextField {

    func getText() -> String? {
        if let text = text,
           !text.isEmpty {
            return text
        } else {
            return nil
        }
    }

}
