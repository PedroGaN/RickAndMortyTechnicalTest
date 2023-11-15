//
//  Optional.swift
//  BasicTemplate
//
//  Created by Pedro García Navalón on 7/11/23.
//

import Foundation

extension Optional {

    func isNil() -> Bool {
        self == nil
    }

}

extension Optional where Wrapped == String {

    func isNilOrEmpty() -> Bool {
        self?.isEmpty ?? true
    }

}
