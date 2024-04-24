//
//  OptionsTextField.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 22/4/24.
//

import Foundation
import UIKit

class OptionsTextField: BaseView {

    // MARK: - Private Properties

    private var options: [String]?

    // MARK: - Properties

    var text: String? {
        didSet {
            textField.text = text
        }
    }

    var placeholder: String? {
        didSet {
            textField.placeholder = placeholder
        }
    }

    // MARK: - IBOutlets

    @IBOutlet private var textField: UITextField!
    @IBOutlet private var optionsTable: SelfSizingTableView!

    // MARK: - Overriden Methods

    override func nibSetup() {
        _ = setupView(nibName: String(describing: OptionsTextField.self))
    }

    // MARK: - Public Methods

    public func configure(withOptions options: [String]) {
        self.options = options
        optionsTable.dataSource = self
        optionsTable.delegate = self
        optionsTable.register(
            OptionsCell.nib,
            forCellReuseIdentifier: OptionsCell.identifier
        )
        optionsTable.alpha = .zero
    }

    public func reload() {
        optionsTable.reloadData()
    }

    // MARK: - Private Methods

    private func handleSelectedOption(_ option: String) {
        text = option.capitalized
        toggleOptionsMenu(toState: false)
    }

    private func toggleOptionsMenu(toState state: Bool? = nil) {
        if let state { optionsTable.isHidden = !state }
        else { optionsTable.isHidden.toggle() }
    }

    // MARK: - IBActions

    @IBAction func toggleOptionsMenuAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.toggleOptionsMenu()
            self?.optionsTable.alpha = self?.optionsTable.isHidden ?? true ? .zero : 1
        }
    }

}

extension OptionsTextField: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options?.count ?? .zero
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        getOptionsCell(forIndexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let options {
            handleSelectedOption(options[indexPath.row])
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .zero
    }

    // MARK: - Cell Getters

    /// OptionsCell
    func getOptionsCell(forIndexPath indexPath: IndexPath) -> UITableViewCell {
        guard let cell = optionsTable.dequeueReusableCell(
            withIdentifier: OptionsCell.identifier,
            for: indexPath
        ) as? OptionsCell else {
            return UITableViewCell()
        }
        if let options {
            cell.bind(withOption: options[indexPath.row], first: indexPath.row == .zero)
        }
        return cell
    }

}
