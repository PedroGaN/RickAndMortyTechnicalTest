//
//  FetchMenuView.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 17/11/23.
//

import Foundation
import UIKit

protocol FetchMenuViewDelegate: AnyObject {
    func handleFetchData(for type: Constants.FetchType)
}

class FetchMenuView: BaseView {

    // MARK: - Private Properties

    private weak var delegate: FetchMenuViewDelegate?

    // MARK: - IBOutlets

    @IBOutlet weak var fetchMenuToggleView: UIView!
    @IBOutlet weak var fetchMenuOptionsView: UIView!
    @IBOutlet weak var fetchOptionCharactersButton: UIButton!
    @IBOutlet weak var fetchOptionLocationsButton: UIButton!
    @IBOutlet weak var fetchOptionEpisodesButton: UIButton!

    // MARK: - Overriden Methods

    override func nibSetup() {
        if !setupView(nibName: String(describing: FetchMenuView.self)).isNil() {
            setupUI()
            localizable()
            setupFetchButtons()
        }
    }

    // MARK: - Public Methods

    public func setDelegate(_ delegate: FetchMenuViewDelegate) {
        self.delegate = delegate
    }

    // MARK: - Private Methods

    private func setupUI() {
        fetchMenuToggleView.setCorners(corners: ViewContants.corner.right, radius: ViewContants.cornerRadius.twenty)
        fetchMenuOptionsView.isHidden = true
    }

    private func localizable() {
        fetchOptionCharactersButton.setTitle(string: "fetch_menu_characters".localized)
        fetchOptionLocationsButton.setTitle(string: "fetch_menu_locations".localized)
        fetchOptionEpisodesButton.setTitle(string: "fetch_menu_episodes".localized)
    }

    private func setupFetchButtons() {
        fetchOptionCharactersButton.tag = Constants.FetchType.characters.rawValue
        fetchOptionLocationsButton.tag = Constants.FetchType.locations.rawValue
        fetchOptionEpisodesButton.tag = Constants.FetchType.episodes.rawValue
    }

    // MARK: - IBActions

    @IBAction func toggleFetchMenuAction(_ sender: Any) {
        fetchMenuOptionsView.toggleVisibility()
    }

    @IBAction func fetchAction(_ sender: UIButton) {
        fetchMenuOptionsView.toggleVisibility()
        switch sender.tag {
        case Constants.FetchType.characters.rawValue: delegate?.handleFetchData(for: .characters)
        case Constants.FetchType.locations.rawValue: delegate?.handleFetchData(for: .locations)
        case Constants.FetchType.episodes.rawValue: delegate?.handleFetchData(for: .episodes)
        default: break
        }
    }

}
