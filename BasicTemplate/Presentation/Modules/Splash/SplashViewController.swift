//
//  SplashViewController.swift
//  BasicTemplate
//
//  Created by Pedro García Navalón on 8/11/23.
//

import Foundation

protocol SplashViewControllerProtocol: BaseViewProtocol {}

class SplashViewController: BaseViewController<SplashPresenterProtocol>, SplashViewControllerProtocol {}
