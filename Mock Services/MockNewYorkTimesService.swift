//
//  MockNewYorkTimesService.swift
//  LegisLink
//
//  Created by Mason Cochran on 4/14/24.
//

import Foundation

@testable import LegisLink


class MockNewYorkTimesService: NewYorkTimesServiceProtocol {
    
    func buildURL() -> URL {
        return URL(string: "https://api.nytimes.com/svc/search/v2/articlesearch.json?begin_date=20240101&end_date=20240102&facet=true&facet_fields=news_desk&facet_filter=true&q=congress&sort=newest&api-key=fakekey")!
    }
    
    func getDailyCongressionalNews(completion: @escaping (Swift.Result<[Doc], any Error>) -> Void) {
        guard let url = Bundle(for: MockNewYorkTimesService.self).url(forResource: "successful-nyt-articles-api-request", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }
        let mockRequest = try? JSONDecoder().decode(NYTRequest.self, from: data)
        completion(.success((mockRequest?.response.docs)!))
    }
    
    
    
    
}
