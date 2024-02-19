//
//  LegisViewModel.swift
//  LegisLink
//
//  Created by Mason Cochran on 1/22/24.
//

import Foundation


class LegisViewModel: ObservableObject {
    private var user: User
    private let congressGovService: CongressGovServiceProtocol
    @Published var dailyBills: [Bill]

    
    init(user: User, congressGovService: CongressGovServiceProtocol) {
        self.user = user
        self.congressGovService = congressGovService
        self.dailyBills = [Bill]()
        self.getDailyLegislationFromCongress()
    }
    
    func getDailyLegislationFromCongress() {
        let group = DispatchGroup()
        
        group.enter()

        congressGovService.getCurrentDayLegislation { bills in
            self.dailyBills = bills
            group.leave()
        }
        group.wait()
        group.notify(queue: DispatchQueue.main) {
        }
    }
}






