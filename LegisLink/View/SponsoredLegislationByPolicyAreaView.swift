//
//  SponsoredLegisListByPolicyAreaView.swift
//  town square
//
//  Created by Mason Cochran on 11/22/23.
//

import Foundation

import SwiftUI



struct SponsoredLegislationByPolicyAreaView: View {
    let user: User
    let official: Official
    let congress: Int
    let givenSponsoredLegislation: [SponsoredLegislation]?
    let givenPolicyArea: String
    
    
    
    var body: some View {
        VStack {
            if !checkIfGivenLegislationExists() {
                HStack {
                    Image(systemName: "xmark.circle")
                    Text("\(self.official.name) does not appear to have sponsored any legislation relating to \(self.givenPolicyArea) for this term")
                }
            } else {
                List {
                    ForEach(givenSponsoredLegislation!, id: \.self) { legis in
                        if legis.congress == congress {
                            NavigationLink(("\(legis.title ?? "No title found for this legislation")"), destination: IndivLegislationView(user:user, official: official, givenSponsoredLegislation: legis))
                        }
                    }
                }
            }
        }
    }
    
    func checkIfGivenLegislationExists() -> Bool {
        var legisCheck = 0
        
        for currentLegislation in givenSponsoredLegislation! {
            if (currentLegislation.policyArea?.name == self.givenPolicyArea && currentLegislation.congress == self.congress) {
                legisCheck += 1
            }
        }
        
        if (legisCheck > 0) {
            return true
        } else {
            return false
        }
        
    }
}
