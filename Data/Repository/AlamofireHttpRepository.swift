//
//  AlamofireHttpRepository.swift
//  Data
//
//  Created by Pedro García Navalón on 15/11/23.
//

import Foundation
import Alamofire
import Domain

public class AlamofireHttpRepository: HttpRepository {

    // MARK: - Properties

    private let baseUrl: String
    var alamofireSession: Session!

    // MARK: - Singleton

    private static var repositoryInstance: AlamofireHttpRepository?

    public static func shared(baseUrl: String) -> HttpRepository {
        if let repositoryInstance = AlamofireHttpRepository.repositoryInstance {
            return repositoryInstance
        } else {
            AlamofireHttpRepository.repositoryInstance = AlamofireHttpRepository(baseUrl: baseUrl)
            AlamofireHttpRepository.repositoryInstance?.setSession()
            return AlamofireHttpRepository.repositoryInstance!
        }
    }

    public func setSession() {
        alamofireSession = Session(configuration: getConfiguration())
    }

    // MARK: - Inicialization

    internal init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    private func getConfiguration() -> URLSessionConfiguration {
        URLCache.shared.removeAllCachedResponses()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = NetworkConstants.Configuration.requestTimeout
        configuration.urlCache = nil
        return configuration
    }

    // MARK: - AlamofireHttpRepository Methods

    // MARK: - Private functions

    internal func getJsonHeader() -> HTTPHeaders {
        var headers: HTTPHeaders = HTTPHeaders()

        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"

        print("\nHEADERS:\n\(headers)\n")
        return headers
    }

    private static func onFailureService(response: AFDataResponse<Data>, error: Error) -> Error {

        if let statusCode = response.response?.statusCode {
            return GenericDataError(type: statusCode.errorType, description: error.localizedDescription)
        } else {
            print(error)
            return GenericDataError(type: .unknown, description: error.localizedDescription)
        }
    }

}
