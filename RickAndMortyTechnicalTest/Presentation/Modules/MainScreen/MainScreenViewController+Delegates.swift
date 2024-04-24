//
//  MainScreenViewController+Delegates.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 16/11/23.
//

import Foundation
import UIKit

// MARK: - TableMenuViewDelegate

extension MainScreenViewController: TableMenuViewDelegate {

    func handleApplyFilters(withFilters filters: FilterCharactersModel) {
        if filters.isEmpty {
            getPresenter()?.handleFetchData(for: .characters)
        } else {
            getPresenter()?.handleFilterCharacters(for: filters)
        }
    }

}
