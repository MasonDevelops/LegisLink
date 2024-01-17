//
//  MyRepsView.swift
//  town square
//
//  Created by Mason Cochran on 5/21/23.
//

import Foundation

import SwiftUI

import UIKit

struct MyRepsView: View {
    @State var user: User
    @ObservedObject private var repsvm: MyRepsViewModel
    
    let googleCivicInfoService = GoogleCivicInfoService()
    let openStatesService = OpenStatesService()
    let openSecretsService = OpenSecretsService()
    let congressGovService = CongressGovService()
   
    
    init(user: User) {
            self.user = user
            self.repsvm = MyRepsViewModel(user: user, googleCivicInfoService: googleCivicInfoService, openStatesService: openStatesService, congressGovService: congressGovService)
        }

    
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    Section("Your Senators") {
                        NavigationLink(repsvm.senatorOne.name, value: repsvm.senatorOne)
                        NavigationLink(repsvm.senatorTwo.name, value: repsvm.senatorTwo)

                    }
                    
                    
                    
                    
                    
                    Section("Your Representative") {
                        NavigationLink(repsvm.representative.name, value: repsvm.representative)
                    }
                }.navigationDestination(for: Official.self) { lawmaker in
                    returnLawmakerView(lawmaker)
                    
                }
            }
        }
    }
    func returnLawmakerView(_ official: Official) -> AnyView {
        var partyAbbrev = ""

        if (official.party == "Democratic Party"){
            partyAbbrev = "(D)"
        }
        
        else if (official.party == "Republican Party"){
            partyAbbrev = "(R)"
        }
        else if (official.party == "Unaffiliated"){
            partyAbbrev = "(I)"
        }
        else {
            partyAbbrev = official.party
        }
        return AnyView(IndividualRepView(user: user, official: official, partyAbbrev: partyAbbrev))
    }
}



