//
//  MockOpenSecretsService.swift
//  FindYourRepTests
//
//  Created by Mason Cochran on 8/5/23.
//

import Foundation


@testable import town_square

private var responseNumber = 1


class MockOpenSecretsService: OpenSecretsServiceProtocol {
    func getTopContributors(from url: URL, completion: @escaping (Swift.Result<Contributors, Error>) -> Void) {
        guard let url = Bundle(for: MockOpenSecretsService.self).url(forResource: "successful-open-secrets-api-response-\(responseNumber)", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }
        let contributors = try? JSONDecoder().decode(Contributors.self, from: data)
        responseNumber += 1
        if responseNumber > 3 {responseNumber = 1}
        completion(.success(contributors!))
    }
}
