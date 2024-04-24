//
//  MainScreenViewController.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 8/11/23.
//

import Foundation
import UIKit

protocol MainScreenViewControllerProtocol: BaseViewProtocol {
    func setTableCharactersInfo(_ items: CharacterInfoCellModels?)
}

class MainScreenViewController: BaseViewController<MainScreenPresenterProtocol> {

    // MARK: - IBOutlets

    @IBOutlet weak var backgroundImageView: UIImageView!
    /// Table Menu Section
    @IBOutlet weak var tableMenuView: TableMenuView!
    /// Fetched Info Table Section
    @IBOutlet weak var emptyListView: UIView!
    @IBOutlet weak var charactersTableView: CharactersTableView!

    // MARK: - Overriden Methods

    override func setupUI() {
        addKeyboardObservers()
        backgroundImageView.image = UIImage(named: "img_location")
        charactersTableView.configure()
        tableMenuView.setDelegate(self)
    }

}
