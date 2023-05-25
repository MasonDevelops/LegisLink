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
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user.picture))
            Text("Email: \(user.email)")
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("LEGISLATION")
        }
        .padding()
        
    }
}
