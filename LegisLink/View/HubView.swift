//
//  HubView.swift
//  LegisLink
//
//  Created by Mason Cochran on 3/5/24.
//

import Foundation

import SwiftUI

struct HubView: View {
    @State private var selection: String? = nil
    let user: User
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    LegisFeedView(user: user)
                } label: {
                    Label("Congress.gov Daily Updates", systemImage: "building.columns")
                }.padding()
                
                NavigationLink {
                    NYTFeedView(user: user)
                } label: {
                    Label("Congressional News", systemImage: "clock")
                }.padding()
                
                NavigationLink {
                    LegisFeedView(user: user)
                } label: {
                    Label("Lobbying Updates", systemImage: "dollarsign.arrow.circlepath")
                }.padding()
                
            }
            .padding()
        }
    }
}







