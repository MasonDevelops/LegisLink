//
//  MyRepsView.swift
//  town square
//
//  Created by Mason Cochran on 5/21/23.
//

import Foundation

import SwiftUI

struct MyRepsView: View {
    @State var user: User
    @ObservedObject private var senatorsvm: SenatorsViewModel
    
    init(user: User) {
            self.user = user
            self.senatorsvm = SenatorsViewModel(user: user)
        }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("MY REPS VIEW")
            Text(user.returnFullAddress())
            Text(senatorsvm.senatorOne.name)
            Text(senatorsvm.senatorTwo.name)
        }
        .padding()
    }
}



