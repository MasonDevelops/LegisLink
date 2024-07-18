//
//  RepContributorsViewModel.swift
//  LegisLink
//
//  Created by Mason Cochran on 12/30/23.
//

import Foundation



class RepContributorsViewModel: ObservableObject {		
    
    private var user: User
    private let openSecretsService: OpenSecretsServiceProtocol
    @Published var official: Official

    init(user: User, openSecretsService: OpenSecretsServiceProtocol, official: Official) {
        self.user = user
        self.openSecretsService = openSecretsService
        self.official = official
        
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            
            let testURLs = openSecretsService.getOpenSecretsAPIURLs(official: official)
            
            getTopContributorInfo(openSecretsURLs: testURLs, openSecretsID: official.opensecretsID!)
            
        } else {
            let openSecretsURLs = openSecretsService.getOpenSecretsAPIURLs(official: official)
            getTopContributorInfo(openSecretsURLs: openSecretsURLs, openSecretsID: official.opensecretsID!)
        }
        
    }
    
    
    func getTopContributorInfo(openSecretsURLs: [URL], openSecretsID: String) {
            
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "com.legislink.network", qos: .userInitiated)
            
        for currentURL in openSecretsURLs {
            queue.async(group: group) {
                self.openSecretsService.getTopContributors(from: openSecretsID, url: currentURL) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let contributors):
                        if self.official.opensecretsID == contributors.response.contributors.attributes.cid {
                            switch contributors.response.contributors.attributes.cycle {
                            case "2012":
                                self.official.twentyTwelveContributors = contributors.response.contributors.contributor
                            case "2014":
                                self.official.twentyFourTeenContributors = contributors.response.contributors.contributor
                            case "2016":
                                self.official.twentySixTeenContributors = contributors.response.contributors.contributor
                            case "2018":
                                self.official.twentyEightTeenContributors = contributors.response.contributors.contributor
                            case "2020":
                                self.official.twentyTwentyContributors = contributors.response.contributors.contributor
                            case "2022":
                                self.official.twentyTwentyTwoContributors = contributors.response.contributors.contributor
                            default:
                                break
                            }
                        }
                    case .failure(let error):
                        print("Unexpected error: \(error).")
                    }
                }
            }
        }
            
        group.notify(queue: DispatchQueue.main) {
            print("All calls have completed.")
        }
    }

}







