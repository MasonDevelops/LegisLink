//
//  User.swift
//  town square
//
//  Created by Mason Cochran on 5/13/23.
//

import Foundation

import JWTDecode

struct User {
    let id: String
    let email: String
    let picture: String
    let street_address: String
    let city: String
    let state: String
    let zip_code: String
}

extension User {
    init?(from idToken: String) {
        guard let jwt = try? decode(jwt: idToken),
              let id = jwt.subject,
              let email = jwt["email"].string,
              let picture = jwt["picture"].string,
              let street_address = jwt["https://mason.example.com/street_address"].string,
              let city = jwt["https://mason.example.com/city"].string,
              let state = jwt["https://mason.example.com/state"].string,
              let zip_code = jwt["https://mason.example.com/zip_code"].string
        else { return nil }
        self.id = id
        self.email = email
        self.picture = picture
        self.street_address = street_address
        self.city = city
        self.state = state
        self.zip_code = zip_code
        
    }
    func returnFullAddress() -> String {
        let addressString = "\(street_address) \(city) \(state) \(zip_code)"
        return addressString
    }
}




