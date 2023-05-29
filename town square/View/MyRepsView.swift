//
//  MyRepsView.swift
//  town square
//
//  Created by Mason Cochran on 5/21/23.
//

import Foundation

import SwiftUI

import UIKit

struct MyRepsView: View {
    @State var user: User
    @ObservedObject private var repsvm: MyRepsViewModel
    
    init(user: User) {
            self.user = user
            self.repsvm = MyRepsViewModel(user: user)
        }

    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("MY REPS VIEW")
            Text(user.returnFullAddress())
            Text(repsvm.senatorOne.name)
            Text(repsvm.senatorTwo.name)
            Text(repsvm.representative.name)
            
            
        }
        .padding()
    }
}



