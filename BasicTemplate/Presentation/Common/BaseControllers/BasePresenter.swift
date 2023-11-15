//
//  BasePresenter.swift
//  BasicTemplate
//
//  Created by Pedro García Navalón on 7/11/23.
//

import Foundation
import Domain

public protocol BasePresenterProtocol: AnyObject {
    func didLoad()
    func willAppear()
    func didAppear()
    func willDisappear()
    func didDisappear()
    func handlePopBeganGesture()
    func handlePopEndedGesture()
}

private protocol BasePresenterDependencies: AnyObject {
    associatedtype View
    associatedtype Router

    func getView() -> View?
    func getRouter() -> Router?
}

open class BasePresenter<View, Router>: BasePresenterDependencies {

    // MARK: - VIPER Dependencies

    weak var view: BaseViewProtocol?
    let router: BaseWireframeProtocol

    // MARK: - Private Properties

    private var loadingViewsCount = 0

    // MARK: - Public Properties

    public var disposeBag: BaseDisposeBag

    // MARK: - Properties

    internal func showLoading() {
        if loadingViewsCount == 0 {
            (getView() as? BaseViewProtocol)?.showLoading()
        }
        loadingViewsCount += 1
    }

    internal func hideLoading() {
        loadingViewsCount -= 1
        if loadingViewsCount <= 0 {
            loadingViewsCount = 0
            (getView() as? BaseViewProtocol)?.hideLoading()
        }
    }

    public func getView() -> View? {
        return view as? View
    }

    public func getRouter() -> Router? {
        return router as? Router
    }

    // MARK: - Initializer

    public init(view: BaseViewProtocol, router: BaseWireframeProtocol) {
        self.disposeBag = BaseDisposeBag()
        self.view = view
        self.router = router
    }

    /**
     Deinit method that sends a notification to Interactor, warning that the Presenter is going to disinstantiate.
     */
    deinit {
        NotificationCenter.default.post(name: disposeBagNotificationId,
                                        object: nil,
                                        userInfo: [disposeBagNotificationParameter: disposeBag])
    }

    // MARK: - BasePresenterProtocol

    /**
     Called when `viewDidLoad()` function of ViewController is called.
     */
    open func didLoad() {}

    /**
     Called when `viewWillAppear(_:)` function of ViewController is called.
     */
    open func willAppear() {}

    /**
     Called when `viewDidAppear(_:)` function of ViewController is called.
     */
    open func didAppear() {}

    /**
     Called when `viewWillDisappear(_:)` function of ViewController is called.
     */
    open func willDisappear() {}

    /**
     Called when `viewDidDisappear(_:)` function of ViewController is called.
     */
    open func didDisappear() {}

    /**
     Called when the user begins the "pop" closing gesture.
     */
    open func handlePopBeganGesture() {}

    /**
     Called when the user finishes the "pop" closing gesture.
     */
    open func handlePopEndedGesture() {
        router.popGesture()
    }

}
