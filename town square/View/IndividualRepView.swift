//
//  IndividualRepView.swift
//  town square
//
//  Created by Mason Cochran on 6/3/23.
//


//Text("\(idnum)")


import Foundation

import SwiftUI

struct IndividualRepView: View {
    let user: User
    let official: Official
    var body: some View {
        VStack {
            Text(official.name)
            Text(official.party)
            Text("\(official.address[0].line1)" as String)
            Text("\(official.address[0].city)" as String)
            Text("\(official.address[0].state)" as String)
            Text("\(official.address[0].zip)" as String)
            Text("\(official.phones[0])")
            Text("\(official.urls[0])")
            Text("\(official.urls[1])")
        }
        VStack {
            Text(official.photoURL!)
            Text("\(official.channels[0].id)" as String)
            Text("\(official.channels[0].type)" as String)
            Text("\(official.channels[1].id)" as String)
            Text("\(official.channels[1].type)" as String)

        }

    }
}




