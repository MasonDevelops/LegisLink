//
//  RepContributorsView.swift
//  town square
//
//  Created by Mason Cochran on 8/16/23.
//

import Foundation


import SwiftUI

struct RepContributorsView: View {
    let user: User
    var official: Official
    let openSecretsService = OpenSecretsService()

    @ObservedObject private var repcvm: RepContributorsViewModel
    @State private var selection = "2012"
    @State private var OFFICIAL_DATA_MISSING = "This official does not appear to have contributor data for the selected year."


    init(user: User, official: Official) {
        self.user = user
        self.official = official
        self.repcvm = RepContributorsViewModel(user: user, openSecretsService: openSecretsService, official: official)
    }
    
    let contributionYears = ["2012", "2014", "2016", "2018", "2020", "2022"]
    
    
    
    
    var body: some View {
        VStack {
            List {
                Picker("Select a contribution year", selection: $selection) {
                    ForEach(contributionYears, id: \.self) {
                        Text($0)
                    }.pickerStyle(.menu)
                }
                if selection == "2022" {
                    if official.twentyTwentyTwoContributors != nil && official.twentyTwentyTwoContributors![0].attributes.orgName != "0" {
                        ForEach(official.twentyTwentyTwoContributors!, id:\.self) { contributor in
                            Text("\(contributor.attributes.orgName): \(contributor.attributes.total)")
                        }
                    } else {
                        Text(OFFICIAL_DATA_MISSING)
                    }

                } else if selection == "2020" {
                    if official.twentyTwentyTwoContributors != nil && official.twentyTwentyContributors![0].attributes.orgName != "0" {
                        ForEach(official.twentyTwentyContributors!, id:\.self) { contributor in
                            Text("\(contributor.attributes.orgName): \(contributor.attributes.total)")
                        }
                    } else {
                        Text(OFFICIAL_DATA_MISSING)
                    }

                } else if selection == "2018" {
                    if official.twentyEightTeenContributors != nil && official.twentyEightTeenContributors![0].attributes.orgName != "0" {
                        ForEach(official.twentyEightTeenContributors!, id:\.self) { contributor in
                            Text("\(contributor.attributes.orgName): \(contributor.attributes.total)")
                        }
                    } else {
                        Text(OFFICIAL_DATA_MISSING)
                    }

                } else if selection == "2016" {
                    if official.twentySixTeenContributors != nil && official.twentySixTeenContributors![0].attributes.orgName != "0" {
                        ForEach(official.twentySixTeenContributors!, id:\.self) { contributor in
                            Text("\(contributor.attributes.orgName): \(contributor.attributes.total)")
                        }
                    } else {
                        Text(OFFICIAL_DATA_MISSING)
                    }

                } else if selection == "2014" {
                    if official.twentyFourTeenContributors != nil && official.twentyFourTeenContributors![0].attributes.orgName != "0" {
                        ForEach(official.twentyFourTeenContributors!, id:\.self) { contributor in
                            Text("\(contributor.attributes.orgName): \(contributor.attributes.total)")
                        }
                    } else {
                        Text(OFFICIAL_DATA_MISSING)
                    }
                } else {
                    if official.twentyTwelveContributors != nil && official.twentyTwelveContributors![0].attributes.orgName != "0" {
                        ForEach(official.twentyTwelveContributors!, id:\.self) { contributor in
                            Text("\(contributor.attributes.orgName): \(contributor.attributes.total)")
                        }
                    } else {
                        Text(OFFICIAL_DATA_MISSING)
                    }
                }
            }
        }
    }
}
