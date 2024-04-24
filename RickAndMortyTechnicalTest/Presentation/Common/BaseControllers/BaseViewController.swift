//
//  BaseViewController.swift
//  RickAndMortyTechnicalTest
//
//  Created by Pedro García Navalón on 7/11/23.
//

import Foundation
import UIKit

public protocol BaseViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showBasicDialog(text: String?, message: String?)
}

private protocol BaseViewDependencies: AnyObject {
    associatedtype Presenter

    func getPresenter() -> Presenter?
}

class BaseViewController<Presenter>: UIViewController,
                                     BaseViewDependencies,
                                     Bindable,
                                     UIGestureRecognizerDelegate,
                                     UIAdaptivePresentationControllerDelegate {

    // MARK: - VIPER Dependencies

    public var presenter: BasePresenterProtocol!

    public func getPresenter() -> Presenter? {
        return presenter as? Presenter
    }

    // MARK: - Properties

    private var loadingView: UIView?

    // MARK: - Lifecycle

    override open func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        presenter.didLoad()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.willAppear()

        /// Add delegate to register the backward gesture
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        /// Add listener to register the pop gesture
        navigationController?.interactivePopGestureRecognizer?.addTarget(self, action: #selector(handlePopGesture))
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.didAppear()
        navigationController?.navigationBar.isHidden = true
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.willDisappear()
    }

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardObservers()
        presenter.didDisappear()
    }

    // MARK: - Bindable
    /// Override method
    open func setupUI() {}

    // MARK: - BaseViewProtocol

    func showLoading() {
        showNativeLoading(parentView: view)
        view.isUserInteractionEnabled = false
    }

    func hideLoading() {
        loadingView?.removeFromSuperview()
        loadingView = nil
        view.isUserInteractionEnabled = true
    }

    func showBasicDialog(text: String? = nil, message: String? = nil) {
        let alert = UIAlertController(
            title: text,
            message: message,
            preferredStyle: .alert
        )

        let alertAction = UIAlertAction(
            title: "accept".localized,
            style: .cancel
        ) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(alertAction)
        alert.preferredAction = alertAction
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Methods

    internal func showNativeLoading(parentView: UIView) {
        if loadingView == nil {
            let loadingHeight: CGFloat = 100
            let loadingRadius: CGFloat = 15
            let loadingView = UIView()
            loadingView.backgroundColor = .black
            loadingView.alpha = 0.4
            loadingView.setCorners(radius: loadingRadius)

            let activityIndicatorView = UIActivityIndicatorView(style: .large)
            activityIndicatorView.center = parentView.center
            activityIndicatorView.startAnimating()

            loadingView.addSubview(childView: activityIndicatorView)
            parentView.addSubview(childView: loadingView, constraintType: .center)

            let heightConstraint = NSLayoutConstraint(item: loadingView, attribute: .height, relatedBy: .equal,
                                                      toItem: nil, attribute: .height,
                                                      multiplier: 1, constant: loadingHeight)
            let widthConstraint = NSLayoutConstraint(item: loadingView, attribute: .width, relatedBy: .equal,
                                                     toItem: loadingView, attribute: .height,
                                                     multiplier: 1, constant: 0)

            parentView.addConstraints([heightConstraint, widthConstraint])
            self.loadingView = loadingView
        }
    }

    // MARK: - Private Methods

    private func getMainScrollView() -> UIScrollView? {
        var scrollView: UIScrollView?
        for view in view.subviews {
            if let scroll = view as? UIScrollView {
                scrollView = scroll
                break
            }
        }
        return scrollView
    }

    // MARK: - UIGestureRecognizerDelegate

    @objc open func handlePopGesture(gesture: UIGestureRecognizer) {
        if gesture.state == .began {
            presenter.handlePopBeganGesture()
        } else if gesture.state == .ended {
            presenter.handlePopEndedGesture()
        }
    }

    // MARK: - Keyboard Control

    public func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown),
                                               name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    public func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc open func keyboardWasShown(_ notification: NSNotification) {
        getMainScrollView()?.setScrollSizeOnKeyboard(notification: notification)
    }

    @objc open func keyboardWillBeHidden(_ notification: NSNotification) {
        getMainScrollView()?.resetScrollSizeOnKeyboard()
    }

}
