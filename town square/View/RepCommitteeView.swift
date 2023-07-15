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
            Section("Committee Memberships") {
                List {
                    ForEach(official.committees!, id: \.self) { committee in
                        Text(committee)
                    }
                }
            }
        }
    }
}



