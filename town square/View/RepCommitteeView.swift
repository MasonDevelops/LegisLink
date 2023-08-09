//
//  RepCommitteeView.swift
//  town square
//
//  Created by Mason Cochran on 7/11/23.
//

import Foundation


import SwiftUI

struct RepCommitteeView: View {
    let user: User
    let official: Official
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



