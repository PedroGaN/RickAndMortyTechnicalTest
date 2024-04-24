//
//  CharactersTableView.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 16/11/23.
//

import Foundation
import UIKit

protocol CharactersTableViewDelegate: AnyObject {}

class CharactersTableView: SelfSizingTableView {

    // MARK: - Private Properties

    private weak var customDelegate: CharactersTableViewDelegate?
    private var items: CharacterInfoCellModels?

    // MARK: - Methods

    func configure() {
        delegate = self
        dataSource = self
        separatorStyle = .none
        register(
            CharacterInfoCell.nib,
            forCellReuseIdentifier: CharacterInfoCell.identifier
        )
    }

    func loadItems(_ items: CharacterInfoCellModels?) {
        self.items = items
        reloadData()
    }

}

extension CharactersTableView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items?.count ?? .zero
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        getCharacterCell(forIndexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            tableView.performBatchUpdates(nil)
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .zero
    }

    // MARK: - Cell Getters

    /// CharacterInfoCell
    func getCharacterCell(forIndexPath indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueReusableCell(
            withIdentifier: CharacterInfoCell.identifier,
            for: indexPath
        ) as? CharacterInfoCell else {
            return UITableViewCell()
        }
        if let items {
            cell.bind(withModel: items[indexPath.row])
        }
        return cell
    }

}
