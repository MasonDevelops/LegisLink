//
//  MockOpenSecretsService.swift
//  FindYourRepTests
//
//  Created by Mason Cochran on 8/5/23.
//

import Foundation

@testable import LegisLink


class MockOpenSecretsService: OpenSecretsServiceProtocol {
    func getTopContributors(from openSecretsID: String, url: URL, completion: @escaping (Swift.Result<Contributors, Error>) -> Void) {
        let mockFileName = url.absoluteString
        guard let newUrl = Bundle(for: MockOpenSecretsService.self).url(forResource: mockFileName, withExtension: "json"),
              let data = try? Data(contentsOf: newUrl) else { return }
        
        do {
            var contributors = try JSONDecoder().decode(Contributors.self, from: data)
            contributors = formatStringValuesToUSDCurrency(contributors: &contributors)
            completion(.success(contributors))
        } catch {
            completion(.failure(error))
        }
    }
    
    func formatStringValuesToUSDCurrency(contributors: inout Contributors) -> Contributors {
        let formatter = NumberFormatter()

        for index in contributors.response.contributors.contributor.indices {
            formatter.numberStyle = .currency
            
            let doubleVersion = Double(contributors.response.contributors.contributor[index].attributes.total)
            
            let formattedValue = formatter.string(for: doubleVersion)
            
            
            contributors.response.contributors.contributor[index].attributes.total = formattedValue!
        }
        return contributors
    }
    
    func getOpenSecretsAPIURLs(official: Official) -> [URL] {
        
        let jm2020 = URL(string: "jerry-moran-2020-contributors")
        let jm2022 = URL(string: "jerry-moran-2022-contributors")
        let jm2012 = URL(string: "jerry-moran-2012-contributors")


        var testURLs = [URL]()
        testURLs.append(jm2020!)
        testURLs.append(jm2022!)
        testURLs.append(jm2012!)

        return testURLs
    }
    
}
