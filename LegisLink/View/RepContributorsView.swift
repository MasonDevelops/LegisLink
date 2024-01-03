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
                    if official.twentyTwentyTwoContributors != nil {
                        ForEach(official.twentyTwentyTwoContributors!, id:\.self) { contributor in
                            Text("\(contributor.attributes.orgName): \(contributor.attributes.total)")
                        }
                    } else {
                        Text("Nothin!")
                    }

                } else if selection == "2020" {
                    if official.twentyTwentyTwoContributors != nil {
                        ForEach(official.twentyTwentyContributors!, id:\.self) { contributor in
                            Text("\(contributor.attributes.orgName): \(contributor.attributes.total)")
                        }
                    } else {
                        Text("Nothin!")
                    }

                } else if selection == "2018" {
                    if official.twentyEightTeenContributors != nil {
                        ForEach(official.twentyEightTeenContributors!, id:\.self) { contributor in
                            Text("\(contributor.attributes.orgName): \(contributor.attributes.total)")
                        }
                    } else {
                        Text("Nothin!")
                    }

                } else if selection == "2016" {
                    if official.twentySixTeenContributors != nil {
                        ForEach(official.twentySixTeenContributors!, id:\.self) { contributor in
                            Text("\(contributor.attributes.orgName): \(contributor.attributes.total)")
                        }
                    } else {
                        Text("Nothin!")
                    }

                } else if selection == "2014" {
                    if official.twentyFourTeenContributors != nil {
                        ForEach(official.twentyFourTeenContributors!, id:\.self) { contributor in
                            Text("\(contributor.attributes.orgName): \(contributor.attributes.total)")
                        }
                    } else {
                        Text("Nothin!")
                    }
                } else {
                    if official.twentyTwelveContributors != nil {
                        ForEach(official.twentyTwelveContributors!, id:\.self) { contributor in
                            Text("\(contributor.attributes.orgName): \(contributor.attributes.total)")
                        }
                    } else {
                        Text("Nothin!")
                    }
                }
            }
        }
    }
}
