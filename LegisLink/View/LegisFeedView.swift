//
//  LegisView.swift
//  town square
//
//  Created by Mason Cochran on 5/21/23.
//

import Foundation

import SwiftUI

struct LegisFeedView: View {
    let user: User
    @ObservedObject private var lfvm: LegisFeedViewModel
    let congressGovService = CongressGovService()
    
    
    init(user: User) {
        self.user = user
        self.lfvm = LegisFeedViewModel(user: user, congressGovService: congressGovService)
    }
    
    
    
    
    var body: some View {
        VStack {
            Text("Congress.Gov Daily Updates")
            Text("Listed below are various pieces of legislation that have been updated on the Congress.Gov website as of today, \(self.lfvm.todaysDate).")
            Section {
                List {
                    ForEach(self.lfvm.dailyBills, id: \.self) { bill in
                        Text(bill.title)
                    }
                }
            }
        }
    }
}
