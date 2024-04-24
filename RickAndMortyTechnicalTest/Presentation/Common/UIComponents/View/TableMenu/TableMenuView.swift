//
//  TableMenuView.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 17/11/23.
//

import Foundation
import UIKit

protocol TableMenuViewDelegate: AnyObject {
    func handleApplyFilters(withFilters filters: FilterCharactersModel)
}

class TableMenuView: BaseView {

    // MARK: - Private Properties

    private weak var delegate: TableMenuViewDelegate?

    // MARK: - Overriden Properties

    override var isHidden: Bool {
        didSet {
            if !isHidden {
                searchStatusTextField.reload()
                searchGenderTextField.reload()
            }
        }
    }

    // MARK: - IBOutlets

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var searchMenuView: UIView!
    @IBOutlet weak var searchNameTextField: UITextField!
    @IBOutlet weak var searchStatusTextField: OptionsTextField!
    @IBOutlet weak var searchSpeciesTextField: UITextField!
    @IBOutlet weak var searchGenderTextField: OptionsTextField!

    // MARK: - Overriden Methods

    override func nibSetup() {
        if !setupView(nibName: String(describing: TableMenuView.self)).isNil() {
            setupUI()
            localizable()
        }
    }

    // MARK: - Public Methods

    public func setDelegate(_ delegate: TableMenuViewDelegate) {
        self.delegate = delegate
        searchNameTextField.delegate = self
        searchSpeciesTextField.delegate = self
    }

    // MARK: - Private Methods

    private func setupUI() {
        view?.setCorners(corners: ViewContants.corner.down, radius: ViewContants.cornerRadius.eight)
    }

    private func localizable() {
        searchButton.setTitle(string: "table_menu_search".localized)
        resetButton.setTitle(string: "table_menu_reset".localized)
        applyButton.setTitle(string: "table_menu_apply".localized)
        searchNameTextField.placeholder = "table_menu_search_name".localized
        searchStatusTextField.placeholder = "table_menu_search_status".localized
        searchSpeciesTextField.placeholder = "table_menu_search_species".localized
        searchGenderTextField.placeholder = "table_menu_search_gender".localized

        searchStatusTextField.configure(withOptions: Utils.getStatusOptions())
        searchGenderTextField.configure(withOptions: Utils.getGenderOptions())
    }

    public enum StatusFilterType: String {
        case alive = "alive"
        case dead = "dead"
        case unknown = "unknown"
    }

    public enum GenderFilterType: String {
        case female = "female"
        case male = "male"
        case genderless = "genderless"
        case unknown = "unknown"
    }

    private func setTextFieldDelegates() {
        view?.subviews.forEach {
            if let textField = $0 as? UITextField {
                textField.delegate = self
            }
        }
    }

    // MARK: - IBActions

    @IBAction private func toggleSearchMenuAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.applyButton.isHidden.toggle()
            self?.resetButton.isHidden.toggle()
            self?.searchMenuView.isHidden.toggle()
            self?.searchMenuView.alpha = self?.searchMenuView.isHidden ?? true ? .zero : 1
        }
    }

    @IBAction private func resetAction(_ sender: UIButton) {
        searchNameTextField.text = ""
        searchStatusTextField.text = ""
        searchSpeciesTextField.text = ""
        searchGenderTextField.text = ""
        delegate?.handleApplyFilters(withFilters: FilterCharactersModel())
    }

    @IBAction private func applySearchOptionsAction(_ sender: UIButton) {
        delegate?.handleApplyFilters(
            withFilters: FilterCharactersModel(
                name: searchNameTextField.text,
                status: searchStatusTextField.text,
                species: searchSpeciesTextField.text,
                gender: searchGenderTextField.text
            )
        )
    }

}

// MARK: - UITextFieldDelegate

extension TableMenuView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

}
