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
    let official: Official
    var body: some View {
        VStack {
            Section("\(official.name)'s Top Contributors for the 2022 election cycle") {
                List {
                    ForEach(official.contributors!, id: \.self) { contributor in
                        Text("\(contributor.attributes.orgName): \(contributor.attributes.total)")
                        }
                    }
                }
            }
        }
    }
