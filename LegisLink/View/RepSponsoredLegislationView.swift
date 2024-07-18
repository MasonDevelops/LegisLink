//
//  RepSponsoredLegislationView.swift
//  town square
//
//  Created by Mason Cochran on 8/17/23.
//

import Foundation

import SwiftUI

struct RepSponsoredLegislationView: View {
    let user: User
    let official: Official
    @ObservedObject private var repslvm: RepSponsoredLegislationViewModel
    let congressGovService = CongressGovService()

    
    init(user: User, official: Official) {
        self.user = user
        self.official = official
        self.repslvm = RepSponsoredLegislationViewModel(user: user, congressGovService: congressGovService, official: official)
        //self.repslvm.bindSponsoredLegislationByPolicy()
    }
    

    var body: some View {
        VStack {
            Section("\(official.name)'s Terms in Congress") {
                List {
                    ForEach(official.termsServedInCongress!, id: \.self) { term in
                        NavigationLink(destination: SponsoredLegisListByTermView(user:user, official: official, congress: term.congress)) {
                                Text("Sponsored Legislation for the \(term.congress), from \(term.startYearString ?? "Bad value") to \(term.endYearString ?? "Bad value")")
                            }
                        }
                    }
                }
            }
        }
    }




