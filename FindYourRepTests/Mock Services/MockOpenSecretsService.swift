//
//  MockOpenSecretsService.swift
//  FindYourRepTests
//
//  Created by Mason Cochran on 8/5/23.
//

import Foundation


@testable import LegisLink

private var responseNumber = 1


class MockOpenSecretsService: OpenSecretsServiceProtocol {
    func getTopContributors(from url: URL, completion: @escaping (Swift.Result<Contributors, Error>) -> Void) {
        guard let url = Bundle(for: MockOpenSecretsService.self).url(forResource: "successful-open-secrets-api-response-\(responseNumber)", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }
        
        do {
            var contributors = try JSONDecoder().decode(Contributors.self, from: data)
            contributors = formatStringValuesToUSDCurrency(contributors: &contributors)
            responseNumber += 1
            if responseNumber > 3 {responseNumber = 1}
            completion(.success(contributors))
        } catch {
            completion(.failure(error))
        }
    }
    
    func formatStringValuesToUSDCurrency(contributors: inout Contributors) -> Contributors {
        let formatter = NumberFormatter()

        for index in contributors.response.contributors.contributor.indices {
            formatter.numberStyle = .currency
            
            var doubleVersion = Double(contributors.response.contributors.contributor[index].attributes.total)
            
            let formattedValue = formatter.string(for: doubleVersion)
            
            
            contributors.response.contributors.contributor[index].attributes.total = formattedValue!
        }
        return contributors
    }
}
