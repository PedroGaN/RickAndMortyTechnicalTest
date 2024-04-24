//
//  MainScreenViewController+Protocol.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 8/11/23.
//

import Foundation
import UIKit

extension MainScreenViewController: MainScreenViewControllerProtocol {

    // MARK: - Protocol

    func setTableCharactersInfo(_ items: CharacterInfoCellModels?) {
        charactersTableView.loadItems(items)
        tableMenuView.isHidden = false
    }

}
