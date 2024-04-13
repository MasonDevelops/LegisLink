//
//  NYTFeedViewModel.swift
//  LegisLink
//
//  Created by Mason Cochran on 3/18/24.
//

import Foundation


class NYTFeedViewModel: ObservableObject {
    private let nytService: NewYorkTimesServiceProtocol
    @Published var articles: [Doc]
    
    init(nytService: NewYorkTimesServiceProtocol) {
        self.nytService = nytService
        self.articles = [Doc]()
        
        self.fetchNYTArticles()
    }
    
    func fetchNYTArticles() {
        let group = DispatchGroup()
        
        group.enter()

        nytService.getDailyCongressionalNews() { result in
            switch result {
            case .success(let docList):
                self.articles = docList
            case .failure(let error):
                print("Unexpected error: \(error).")
            }
            group.leave()
        }
        group.wait()
        group.notify(queue: DispatchQueue.main) {
        }
    }
    
    
}
