//
//  IndivLegislationView.swift
//  town square
//
//  Created by Mason Cochran on 11/26/23.
//


import Foundation

import SwiftUI



struct IndivLegislationView: View {
    let user: User
    let official: Official
    let givenSponsoredLegislation: SponsoredLegislation
    
    var body: some View {

            VStack (alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: "doc.append")
                    Text("\(self.givenSponsoredLegislation.title ?? "No title found!")")
                }.padding(20)
            }
            .padding()
            .cornerRadius(20) /// make the background rounded
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.blue, lineWidth: 5)
            )
        List {
                Section("Legislation Summary:") {
                    VStack (alignment: .leading) {
                        HStack {
                            Image(systemName: "calendar.circle")                   
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                            Text("Date introduced: \(self.givenSponsoredLegislation.introducedDate)")
                        }
                        
                        
                        Divider()
                        
                        HStack {
                            Image(systemName: "person.badge.shield.checkmark")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                            Text("Congress: \(self.givenSponsoredLegislation.congress)")
                        }
                        
                        Divider()

                        
                        HStack {
                            Image(systemName: "number.circle")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                            Text("Legislation number: \(self.givenSponsoredLegislation.number ?? "No number found!")")
                        }
                    }
                }
                
                Section("Latest Action for Legislation") {
                    VStack (alignment: .leading) {
                        
                        HStack {
                            Image(systemName: "newspaper")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                            Text("\(self.givenSponsoredLegislation.latestAction?.text ?? "No latest action found")").italic()
                        }
                        
                        Divider()

                        HStack {
                            Image(systemName: "calendar.circle")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                            Text("Latest action date: \(self.givenSponsoredLegislation.latestAction?.actionDate ?? "No date for latest action found")")
                        }
                    }
                }
                
                Section ("Other") {
                    VStack (alignment: .leading) {
                        HStack {
                            Image(systemName: "pencil.and.scribble")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                            Text("Legislation type: \(self.givenSponsoredLegislation.type ?? "No type found")")
                        }
                        
                        Divider()
                        
                        HStack {
                            Image(systemName: "number.circle")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                            Text("Amendment Number: \(self.givenSponsoredLegislation.amendmentNumber ?? "No amendment number found")")
                        }
                    }
                }
            }
        }
    }

