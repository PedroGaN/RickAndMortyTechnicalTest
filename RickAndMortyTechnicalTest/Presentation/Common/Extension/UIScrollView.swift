//
//  UIScrollView.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 23/11/23.
//

import Foundation
import UIKit

extension UIScrollView {

    func setScrollSizeOnKeyboard(notification: NSNotification) {
        guard let info = notification.userInfo,
            let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size else {
            print("Error: No size for keyboard in info")
            return
        }
        
        let contentInsets = UIEdgeInsets(
            top: .zero,
            left: .zero,
            bottom: keyboardSize.height + ViewContants.scrollViewSpacing.topTen,
            right: .zero
        )
        self.contentInset = contentInsets
        scrollIndicatorInsets = contentInsets
    }

    func resetScrollSizeOnKeyboard() {
        let contentInsets = UIEdgeInsets.zero
        self.contentInset = contentInsets
        scrollIndicatorInsets = contentInsets
    }
}
