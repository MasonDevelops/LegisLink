//
//  SenatorViewModel.swift
//  town square
//
//  Created by Mason Cochran on 5/25/23.
//

import Foundation



class MyRepsViewModel: ObservableObject {
    
    private var user: User
   
    @Published var senatorOne = Official(name: "null", address: [NormalizedInput(
        
        line1: "String",
        city: "City",
        state: "State",
        zip: "Zip")],
                                         
        party: "party", phones: ["Phone"], urls: ["urls"], photoURL: "photoURL", channels: [Channel(
            type: "type",
            id: "id"
        )], geocodingSummaries: [GeocodingSummary(
            queryString: "queryString", featureID: FeatureID(cellID: "cellID", fprint: "fprint"), featureType: "featureType", positionPrecisionMeters: 0.0, addressUnderstood: true)])
    
    
    @Published var senatorTwo = Official(name: "null", address: [NormalizedInput(
        
        line1: "String",
        city: "City",
        state: "State",
        zip: "Zip")],
                                         
        party: "party", phones: ["Phone"], urls: ["urls"], photoURL: "photoURL", channels: [Channel(
            type: "type",
            id: "id"
        )], geocodingSummaries: [GeocodingSummary(
            queryString: "queryString", featureID: FeatureID(cellID: "cellID", fprint: "fprint"), featureType: "featureType", positionPrecisionMeters: 0.0, addressUnderstood: true)])
    
    @Published var representative = Official(name: "null", address: [NormalizedInput(
        
        line1: "String",
        city: "City",
        state: "State",
        zip: "Zip")],
                                         
        party: "party", phones: ["Phone"], urls: ["urls"], photoURL: "photoURL", channels: [Channel(
            type: "type",
            id: "id"
        )], geocodingSummaries: [GeocodingSummary(
            queryString: "queryString", featureID: FeatureID(cellID: "cellID", fprint: "fprint"), featureType: "featureType", positionPrecisionMeters: 0.0, addressUnderstood: true)])


    init(user: User){
        self.user = user
        getReps()
    }
     func getReps() {
        let gapiKey = ProcessInfo.processInfo.environment["Google_API_Key"]
        let fullAddress = user.returnFullAddress()
        let fullAddressEncoded = fullAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL(string: "https://www.googleapis.com/civicinfo/v2/representatives?key=\(gapiKey!)&address=\(fullAddressEncoded!)&includedOffices=true&levels=country&roles=legislatorUpperBody&roles=legislatorLowerBody") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
            do {
                let lawmakers = try JSONDecoder().decode(Reps.self, from: data)
                let senatorOne = lawmakers.officials[0]
                let senatorTwo = lawmakers.officials[1]
                let representative = lawmakers.officials[2]
                self.senatorOne = senatorOne
                self.senatorTwo = senatorTwo
                self.representative = representative

            } catch {
                print("Unexpected error: \(error).")
            }
        }
        .resume()
    }
    
    
    
    
}
