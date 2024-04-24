//
//  OptionsCell.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 22/4/24.
//

import Foundation
import UIKit

class OptionsCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var separator: UIView!

    // MARK: - Overridden Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    // MARK: - Internal Methods

    internal func bind(withOption option: String, first: Bool = false) {
        optionLabel.text = option.capitalized
        separator.isHidden = first
    }

}
