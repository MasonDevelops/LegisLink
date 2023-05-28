//
//  SenatorViewModel.swift
//  town square
//
//  Created by Mason Cochran on 5/25/23.
//

import Foundation



class SenatorsViewModel: ObservableObject {
    
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

    init(user: User){
        self.user = user
        getSenators()
    }
     func getSenators() {
        let gapiKey = ProcessInfo.processInfo.environment["Google_API_Key"]
        let fullAddress = user.returnFullAddress()
        let fullAddressEncoded = fullAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL(string: "https://www.googleapis.com/civicinfo/v2/representatives?key=\(gapiKey!)&address=\(fullAddressEncoded!)&includedOffices=true&levels=country&roles=legislatorUpperBody") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
            do {
                let senators = try JSONDecoder().decode(Senators.self, from: data)
                let senatorOne = senators.officials[0]
                let senatorTwo = senators.officials[1]
                self.senatorOne = senatorOne
                self.senatorTwo = senatorTwo

            } catch {
                print("Unexpected error: \(error).")
            }
        }
        .resume()
    }
    
    
}
