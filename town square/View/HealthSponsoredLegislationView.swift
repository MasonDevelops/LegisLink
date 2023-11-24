//
//  HealthSponsoredLegislationView.swift
//  town square
//
//  Created by Mason Cochran on 11/24/23.
//

import Foundation



//
//  SponsoredLegisListByPolicyAreaView.swift
//  town square
//
//  Created by Mason Cochran on 11/22/23.
//

import Foundation

import SwiftUI



struct HealthSponsoredLegislationView: View {
    let user: User
    let official: Official
    let congress: Int
    
    
    
    var body: some View {
        VStack {
            if isThereAnyHealthSponsoredLegislation() == false {
                Text("There does not appear to be any taxation legislation for this term")
            } else {
                List {
                    ForEach(official.healthSponsoredLegislation!, id: \.self) { healthLegis in
                        if healthLegis.congress == congress {
                            Text("\(healthLegis.title ?? "No title found")")
                        }
                    }
                }
            }
        }
    }
    
    func isThereAnyHealthSponsoredLegislation() -> Bool {
        var healthLegisCount = 0
        official.healthSponsoredLegislation!.forEach { currentLegis in
            if (currentLegis.congress == self.congress) {
                healthLegisCount += 1
            }
        }
        if (healthLegisCount == 0) {
            return false
        } else {
            return true
        }
    }
}
