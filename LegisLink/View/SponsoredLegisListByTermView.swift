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
                    NavigationLink("Taxation", destination: SponsoredLegislationByPolicyAreaView(user:user, official: official, congress: congress, givenSponsoredLegislation: official.taxationSponsoredLegislation, givenPolicyArea: "Taxation"))
                    
                    
                    NavigationLink("Health", destination: SponsoredLegislationByPolicyAreaView(user:user, official: official, congress: congress, givenSponsoredLegislation: official.healthSponsoredLegislation, givenPolicyArea: "Health"))
                    
                    
                    NavigationLink("Government Operations & Politics", destination: SponsoredLegislationByPolicyAreaView(user:user, official: official, congress: congress, givenSponsoredLegislation: official.govtOpsAndPoliticsLegislation, givenPolicyArea: "Government Operations and Politics"))
                    
                    NavigationLink("Armed Forces & National Security", destination: SponsoredLegislationByPolicyAreaView(user:user, official: official, congress: congress, givenSponsoredLegislation: official.armedForcesAndNatlSecurityLegislation, givenPolicyArea: "Armed Forces and National Security"))
                    
                    
                    NavigationLink("Congress", destination: SponsoredLegislationByPolicyAreaView(user:user, official: official, congress: congress, givenSponsoredLegislation: official.congressLegislation, givenPolicyArea: "Congress"))
                    
                    
                    NavigationLink("International Affairs", destination: SponsoredLegislationByPolicyAreaView(user:user, official: official, congress: congress, givenSponsoredLegislation: official.intlAffairsLegislation, givenPolicyArea: "International Affairs"))
                    
                    
                    NavigationLink("Public Lands & Natural Resources", destination: SponsoredLegislationByPolicyAreaView(user:user, official: official, congress: congress, givenSponsoredLegislation: official.publicLandsNatResourcesLegislation, givenPolicyArea: "Public Lands and Natural Resources"))
                    
                    
                    NavigationLink("Foreign Trade & International Finance", destination: SponsoredLegislationByPolicyAreaView(user:user, official: official, congress: congress, givenSponsoredLegislation: official.foreignTradeAndIntlFinanceLegislation, givenPolicyArea: "Foreign Trade and International Finance"))
                    
                    
                    NavigationLink("Crime & Law Enforcement", destination: SponsoredLegislationByPolicyAreaView(user:user, official: official, congress: congress, givenSponsoredLegislation: official.crimeAndLawEnforcementLegislation, givenPolicyArea: "Crime and Law Enforcement"))
                    
                    
                    NavigationLink("Transportation & Public Works", destination: SponsoredLegislationByPolicyAreaView(user:user, official: official, congress: congress, givenSponsoredLegislation: official.transportationAndPublicWorksLegislation, givenPolicyArea: "Transportation and Public Works"))
                    
                    NavigationLink("Education", destination: SponsoredLegislationByPolicyAreaView(user:user, official: official, congress: congress, givenSponsoredLegislation: official.educationLegislation, givenPolicyArea: "Education"))
                    
                    NavigationLink("Social Welfare", destination: SponsoredLegislationByPolicyAreaView(user:user, official: official, congress: congress, givenSponsoredLegislation: official.socialWelfareLegislation, givenPolicyArea: "Social Welfare"))
                    
                }
            }
        }
    }
}


