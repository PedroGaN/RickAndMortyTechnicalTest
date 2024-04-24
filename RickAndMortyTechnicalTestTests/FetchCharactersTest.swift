//
//  FetchCharactersTest.swift
//  RickAndMortyTechnicalTestTests
//
//  Created by Pedro García Navalón on 24/4/24.
//

import XCTest
@testable import RickAndMortyTechnicalTest
@testable import Domain

final class FetchCharactersTest: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testFetchCharacterListOK() {
        let exp = expectation(description: "Fetch Characters from server OK")

        let session: URLSession = URLSession(configuration: .default)
        let url = URL(string: "https://rickandmortyapi.com/api/character")
        guard let url else { return }

        session.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(response)
            exp.fulfill()
        }.resume()
        waitForExpectations(timeout: 5.0) { (error) in
            print(error?.localizedDescription ?? "error")
        }

    }

    func testFilterCharacterListKO() {
        let exp = expectation(description: "Filter Characters from server KO")

        let session: URLSession = URLSession(configuration: .default)
        var urlComponents = URLComponents(string: "https://rickandmortyapi.com/api/character")
        urlComponents?.queryItems = [URLQueryItem(name: "name", value: "aaa")]
        guard let url = urlComponents?.url else { return }
        var request = try? URLRequest(url: url, method: .get)
        request?.addValue("Content-Type", forHTTPHeaderField: "application/json")
        guard let request else { return }

        session.dataTask(with: request) { data, response, error in
            XCTAssertNotNil(error)
            exp.fulfill()
        }.resume()
        waitForExpectations(timeout: 5.0) { (error) in
            print(error?.localizedDescription ?? "error")
        }
    }

    func testPerformanceExample() throws {
        self.measure {}
    }

}
