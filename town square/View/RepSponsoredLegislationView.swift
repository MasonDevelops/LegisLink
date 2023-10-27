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
    var body: some View {
        VStack {
            Section("\(official.name)'s Sponsored Legislation") {
                List {
                    ForEach(official.sponsoredLegislation!, id: \.self) { legislation in
                        Text("\(legislation.title ?? "No Title")")
                        }
                    }
                }
            }
        }
    }




