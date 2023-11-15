//
//  BaseInteractor.swift
//  Domain
//
//  Created by Pedro García Navalón on 15/11/23.
//

import Foundation

open class BaseInteractor<Input, Output>: Disposable {

    // MARK: - Properties

    private var disposeBag: BaseDisposeBag?

    open var dispatchQueue: DispatchQueue {
        return DispatchQueue.global(qos: .background)
    }

    // MARK: - Initializer

    public init() {
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(disposeBagValueDisposed),
                         name: disposeBagNotificationId,
                         object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: disposeBagNotificationId, object: nil)
    }

    // MARK: - Public Methods

    public func execute(_ parameter: Input? = nil,
                        onSuccess: ((Output) -> Void)? = nil,
                        onFailure: ((Error) -> Void)? = nil) -> Disposable {
        return executeInteractor(parameter, onSuccess: onSuccess, onFailure: onFailure)
    }

    public func disposed(by bag: BaseDisposeBag) {
        self.disposeBag = bag
    }

    public func dispose() {
        disposeBag = nil
    }

    // MARK: - Private Methods

    private func executeInteractor(_ parameter: Input?,
                                   onSuccess: ((Output) -> Void)?,
                                   onFailure: ((Error) -> Void)?) -> Disposable {

        dispatchQueue.async { [weak self] in
            guard let strongSelf = self else {
                return
            }

            let onSuccessCompletion = strongSelf.onCompletion(onSuccess)
            let onFailureCompletion = strongSelf.onCompletion(onFailure)

            if let parameter = parameter, Input.self != Void.self {
                strongSelf.handle(parameter: parameter,
                                  onSuccess: onSuccessCompletion,
                                  onFailure: onFailureCompletion)
            } else {
                strongSelf.handle(onSuccess: onSuccessCompletion,
                                  onFailure: onFailureCompletion)
            }
        }

        return self
    }

    private func onCompletion<T>(_ onCompletion: ((T) -> Void)?) -> ((T) -> Void) {
        return { [weak self] object in
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else {
                    return
                }

                if let onCompletion = onCompletion,
                    strongSelf.disposeBag != nil {
                    onCompletion(object)
                }
            }
        }
    }

    private func getVoidCompletion<T>(_ onCompletion: @escaping (T) -> Void) -> (() -> Void)? {
        if let onVoidCompletion = onCompletion as? ((()) -> Void) {
            return { onVoidCompletion(()) }
        }
        return nil
    }

    @objc private func disposeBagValueDisposed(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String: Any],
            let bag = userInfo[disposeBagNotificationParameter] as? BaseDisposeBag {
            if bag === disposeBag {
                dispose()
            }
        }
    }

    open func handle(parameter: Input,
                     onSuccess: @escaping (Output) -> Void,
                     onFailure: @escaping (Error) -> Void) {}

    open func handle(onSuccess: @escaping (Output) -> Void,
                     onFailure: @escaping (Error) -> Void) {}

}
