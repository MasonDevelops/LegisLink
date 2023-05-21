//
//  Login.swift
//  town square
//
//  Created by Mason Cochran on 5/13/23.
//

import Foundation

import SwiftUI
import Auth0

struct LoginView: View {
    @State var user: User?

    var body: some View {
        if let user = self.user {
            VStack {
                ProfileView(user: user)
                Button("Logout", action: self.logout)
            }
        } else {
            VStack {
                Text("Welcome to Town Square. \("\n") Please select the button below to continue.").multilineTextAlignment(.center).padding(5)
                Spacer()
                Button(action: self.login) {
                    Text("Login & Register")
                }.buttonStyle(.borderedProminent)
                Spacer()
            }
            
        }
    }
}

extension LoginView {
    func login() {
        Auth0
            .webAuth()
            .start { result in
                switch result {
                case .success(let credentials):
                    self.user = User(from: credentials.idToken)
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }

    func logout() {
        Auth0
            .webAuth()
            .clearSession { result in
                switch result {
                case .success:
                    self.user = nil
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }
    
    func register() {
        print("REGISTER")
    }
}


