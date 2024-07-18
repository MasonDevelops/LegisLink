//
//  RepCommitteeViewModel.swift
//  LegisLink
//
//  Created by Mason Cochran on 6/19/24.
//

import Foundation



class RepCommitteesViewModel: ObservableObject {
    
    private var user: User
    private var upperOrLowerHouse: String
    private let openStatesService: OpenStatesServiceProtocol

    
    @Published var official: Official

    init(user: User, openStatesService: OpenStatesServiceProtocol, official: Official) {
        self.user = user
        self.openStatesService = openStatesService
        self.official = official
        
        if (official.chamber == "Senate") {
            self.upperOrLowerHouse = "upper"
        } else {
            self.upperOrLowerHouse = "lower"
        }
        
        parseCommitteeLists(chamber: self.upperOrLowerHouse, official: official)
    }
    
    
    func parseCommitteeLists(chamber: String, official: Official ) {
        let maxPageGroup = DispatchGroup()
        let group = DispatchGroup()
        var currentPage = 1
        var maxPage = 0
        
        
        maxPageGroup.enter()
        openStatesService.getMaxCommitteePages(from: chamber) { maxPageCallVal in
            maxPage = maxPageCallVal
            maxPageGroup.leave()
        }
        
        maxPageGroup.wait()
        

        
        while currentPage <= maxPage {
            group.enter()
            openStatesService.getCommitteeData(from: chamber, currentPage: currentPage) { [weak self] result in
                switch result {
                case .success(let committeeListResults):
                    if self!.official.committees == nil {
                        self!.official.committees = [:]
                    }
                    
                    if self!.official.committees == nil {
                        self!.official.committees = [:]
                    }
                    
                    for committeeListResult in committeeListResults.results {
                        for memberships in committeeListResult.memberships {
                            if (self!.official.ocdID == memberships.person.id) {
                                self!.official.committees![committeeListResult.name] = memberships.role.rawValue
                            }
                            if (self!.official.ocdID == memberships.person.id) {
                                self!.official.committees![committeeListResult.name] = memberships.role.rawValue
                            }
                        }
                    }
                case .failure(let error):
                    print("Unexpected error: \(error).")
                }
                
                currentPage = currentPage + 1
                group.leave()
            }
            group.wait()
        }
        group.notify(queue: DispatchQueue.main) {
        }
    }
    
  
    
    
}
