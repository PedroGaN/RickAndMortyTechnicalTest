//
//  BaseWireframe.swift
//  BasicTemplate
//
//  Created by Pedro García Navalón on 7/11/23.
//

import Foundation
import UIKit

enum RouteTransitionType {
    case root
    case push
    case pushModal
    case modal
}

public protocol BaseWireframeProtocol: AnyObject {
    func pop(animated: Bool)
    func popGesture()
}

class BaseWireframe {

    // MARK: - Properties

    internal static var routerStack: [[UIViewController: RouteTransitionType]] = []

    // MARK: - Initializer

    public init() {}

    // MARK: - Private Functions

    private func getLastNavigationController() -> UINavigationController? {
        var navigationController: UINavigationController?

        for router in BaseWireframe.routerStack.reversed() {
            if let navController = router.keys.first as? UINavigationController {
                navigationController = navController
                break
            }
        }

        return navigationController
    }

    private func getTotalViewsFromLastNavController() -> Int {
        var totaViewControllers = 0

        for router in BaseWireframe.routerStack.reversed() {
            if let transitionType = router.values.first {
                if transitionType != .root {
                    totaViewControllers += 1
                } else {
                    break
                }
            }
        }

        return totaViewControllers
    }

    private func isViewInStack(_ view: UIViewController) -> Bool {
        var isInStack = false

        for router in BaseWireframe.routerStack {
            if router.keys.first == view {
                isInStack = true
                break
            }
        }

        return isInStack
    }

    private func addViewToStack(_ view: UIViewController, _ routeTransitionType: RouteTransitionType) {
        if !isViewInStack(view) {
            BaseWireframe.routerStack.append([view: routeTransitionType])
        }
    }

    // MARK: - Public functions

    public func getViewFromStoryboard(name: String) -> UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: name)
    }

    public func push(view: UIViewController, animated: Bool = true) {
        let navigationController = getLastNavigationController() ?? Application.getNavigationController()
        navigationController.pushViewController(view, animated: animated)

        addViewToStack(navigationController, .root)
        addViewToStack(view, .push)
    }

    public func pushRoot(view: UIViewController, animated: Bool = true) {
        let navigationController = Application.getNavigationController(rootVC: view)
        navigationController.pushRootViewController(animated: animated)

        BaseWireframe.routerStack.removeAll()
        addViewToStack(navigationController, .root)
        addViewToStack(view, .push)
    }

    // MARK: - BaseWireframeProtocol

    public func pop(animated: Bool = true) {
        let navigationController = getLastNavigationController() ?? Application.getNavigationController()
        navigationController.popViewController(animated: animated)

        popGesture()
    }

    public func popGesture() {
        if getTotalViewsFromLastNavController() > 1 {
            BaseWireframe.routerStack.removeLast()
        }
    }

}
