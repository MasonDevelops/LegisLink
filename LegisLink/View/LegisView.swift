//
//  LegisView.swift
//  town square
//
//  Created by Mason Cochran on 5/21/23.
//

import Foundation

import SwiftUI

struct LegisView: View {
    let user: User
    @ObservedObject private var lvm: LegisViewModel
    let congressGovService = CongressGovService()
    
    
    init(user: User) {
        self.user = user
        self.lvm = LegisViewModel(user: user, congressGovService: congressGovService)
    }
    
    
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(Array(self.lvm.dailyBills), id: \.self) { bill in
                    Text("\(bill.title)")
                }
            }
        }
    }
}
