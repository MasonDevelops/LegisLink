//
//  ContentView.swift
//  town square
//
//  Created by Mason Cochran on 5/10/23.
//

import SwiftUI

struct ContentView: View {
    let user: User
    var body: some View {
        TabView {
            LegisView(user: user).tabItem {
                Image(systemName: "house")
                Text("Legislation")
            }
            MyRepsView(user: user).tabItem {
                Image(systemName: "person.3")
                Text("My Representatives")
            }
            SettingsView(user: user).tabItem {
                Image(systemName: "gearshape")
                Text("Settings")
            }
            MyProfileView(user: user).tabItem {
                Image(systemName: "person.crop.circle")
                Text("My Profile")
            }
        }
    }
}

