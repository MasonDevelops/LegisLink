//
//  MockGoogleCivicInfoService.swift
//  FindYourRepTests
//
//  Created by Mason Cochran on 8/5/23.
//

import Foundation


@testable import LegisLink

class MockGoogleCivicInfoService: GoogleCivicInfoServiceProtocol {
    func getReps(from url: URL, completion: @escaping (Swift.Result<Reps, Error>) -> Void) {
        guard let url = Bundle(for: MockGoogleCivicInfoService.self).url(forResource: "successful-google-civic-info-api-response", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }
        let reps = try? JSONDecoder().decode(Reps.self, from: data)
        completion(.success(reps!))
    }
}
