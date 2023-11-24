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
                Text("Below are the different policy areas for congressional legislation for the \(congress.description)!")
                Section("POLICY AREAS") {
                    if (official.taxationSponsoredLegislation!.count > 0) {
                        NavigationLink("Taxation", destination: TaxationSponsoredLegislationView(user:user, official: official, congress: congress))
                    }
                    
                    if (official.healthSponsoredLegislation!.count > 0) {
                        NavigationLink("Health", destination: HealthSponsoredLegislationView(user:user, official: official, congress: congress))
                    }
                }
            }
        }
    }
}


