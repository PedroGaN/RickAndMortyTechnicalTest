//
//  BaseDisposeBag.swift
//  Domain
//
//  Created by Pedro García Navalón on 15/11/23.
//

import Foundation

public protocol Disposable {
    func disposed(by bag: BaseDisposeBag)
    func dispose()
}

public class BaseDisposeBag {
    public init() {}
}

public let disposeBagNotificationId = NSNotification.Name(rawValue: "disposeBagNotificationId")
public let disposeBagNotificationParameter = "disposeBagNotificationParameter"
