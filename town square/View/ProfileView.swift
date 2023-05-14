//
//  ProfileView.swift
//  town square
//
//  Created by Mason Cochran on 5/13/23.
//

import Foundation


import SwiftUI

struct ProfileView: View {
    let user: User

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user.picture))
            Text("Email: \(user.email)")
        }
    }
}



