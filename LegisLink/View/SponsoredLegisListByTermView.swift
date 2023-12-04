//
//  SponsoredLegislationListView.swift
//  town square
//
//  Created by Mason Cochran on 11/19/23.
//

import SwiftUI

struct SponsoredLegisListByTermView: View {
    let user: User
    let official: Official
    let congress: Int
    var body: some View {
        VStack {
            List {
                Text("Below are the different policy areas for congressional legislation for the \(congress.description), as well as the number of legislation sponsored.")
                Section("POLICY AREAS") {
                    NavigationLink("Taxation - (Total legislation: \(official.taxationSponsoredLegislation!.count))", destination: SponsoredLegislationByPolicyAreaView(user:user, official: official, congress: congress, givenSponsoredLegislation: official.taxationSponsoredLegislation, givenPolicyArea: "Taxation"))
                    
                    
                    NavigationLink("Health - (Total legislation: \(official.healthSponsoredLegislation!.count))", destination: SponsoredLegislationByPolicyAreaView(user:user, official: official, congress: congress, givenSponsoredLegislation: official.healthSponsoredLegislation, givenPolicyArea: "Health"))
                    
                    
                    NavigationLink("Government Operations & Politics - (Total legislation: \(official.govtOpsAndPoliticsLegislation!.count))", destination: SponsoredLegislationByPolicyAreaView(user:user, official: official, congress: congress, givenSponsoredLegislation: official.govtOpsAndPoliticsLegislation, givenPolicyArea: "Government Operations and Politics"))
                    
                    NavigationLink("Armed Forces & National Security - (Total legislation: \(official.armedForcesAndNatlSecurityLegislation!.count))", destination: SponsoredLegislationByPolicyAreaView(user:user, official: official, congress: congress, givenSponsoredLegislation: official.armedForcesAndNatlSecurityLegislation, givenPolicyArea: "Armed Forces and National Security"))
                    
                    
                    NavigationLink("Congress - (Total legislation: \(official.congressLegislation!.count))", destination: SponsoredLegislationByPolicyAreaView(user:user, official: official, congress: congress, givenSponsoredLegislation: official.congressLegislation, givenPolicyArea: "Congress"))
                    
                    
                    NavigationLink("International Affairs - (Total legislation: \(official.intlAffairsLegislation!.count))", destination: SponsoredLegislationByPolicyAreaView(user:user, official: official, congress: congress, givenSponsoredLegislation: official.intlAffairsLegislation, givenPolicyArea: "International Affairs"))
                    
                }
            }
        }
    }
}


