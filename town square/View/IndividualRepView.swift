//
//  IndividualRepView.swift
//  town square
//
//  Created by Mason Cochran on 6/3/23.
//


import Foundation

import SwiftUI

struct IndividualRepView: View {
    let user: User
    let official: Official
    var partyAbbrev: String
    var body: some View {
        
        
        
        
        Section {
            if (official.photoURL == "photoURL"){
                Image("default_lawmaker_img")
                    .resizable()
                    .frame(width:100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.blue, lineWidth: 2))
            }
            else {
                AsyncImage(url: URL(string: official.photoURL!))
            }
            
            Text("\(official.name) \(partyAbbrev)").font(.headline)
            Spacer()
                    
        }
        List {
            Section ("Basic Contact Information") {
                VStack (alignment: .leading) {
                    Text("Washington DC Address: \(official.address[0].line1) \(official.address[0].city) \(official.address[0].state) \(official.address[0].zip)" as String)
                    Text("Phone Number: \(official.phones[0])")

                }
            }
            
            Section ("Social Media") {
                VStack (alignment: .leading) {
                    Text("\(official.channels[1].type): @\(official.channels[1].id)")
                    Text("\(official.channels[0].type): @\(official.channels[0].id)")
                }
            }
            
            Section ("Websites") {
                let linkOne = official.urls[0]
                let linkTwo = official.urls[1]
                VStack (alignment: .leading) {
                    Link("\(official.urls[0])", destination: URL(string: linkOne)!)
                    Divider()
                    Link("\(official.urls[1])", destination: URL(string: linkTwo)!)
                }
            }
        }
    }
}




