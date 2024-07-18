//
//  RepCommitteeView.swift
//  town square
//
//  Created by Mason Cochran on 7/11/23.
//

import Foundation


import SwiftUI

struct RepCommitteesView: View {
    let user: User
    let official: Official
    let openStatesService = OpenStatesService()
    
    @ObservedObject private var repcvm: RepCommitteesViewModel
    
    init(user: User, official: Official) {
        self.user = user
        self.official = official
        self.repcvm = RepCommitteesViewModel(user: user, openStatesService: openStatesService, official: official)
    }
    
    var body: some View {
        VStack {
            Section("\(official.name)'s Committee Memberships") {
                List {
                    ForEach(Array(official.committees!.keys), id: \.self) { key in
                        Section(header: Text(key)) {
                            Text("Rank: \(official.committees![key]!)")
                        }
                    }
                }
            }
        }
    }
}



