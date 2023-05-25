//
//  MyProfileView.swift
//  town square
//
//  Created by Mason Cochran on 5/21/23.
//

import Foundation

import SwiftUI

struct MyProfileView: View {
    let user: User
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("MY PROFILE VIEW")
        }
        .padding()
    }
}


