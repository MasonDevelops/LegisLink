//
//  CongressGov API Service.swift
//  town square
//
//  Created by Mason Cochran on 8/17/23.
//

import Foundation




protocol CongressGovServiceProtocol {
    func createSponsoredLegislationURL(bioGuideID: String, pageOffset: Int) -> URL
    func getSponsoredLegislationPackage(from url: URL, completion: @escaping (Swift.Result<SponsoredLegislationPackage, Error>) -> Void)
    func getMaxPagination(bioGuideID: String, completion: @escaping (Int) -> Void)
}

class CongressGovService: CongressGovServiceProtocol {
    
    private var openStatesAPIKey: String {
        get {return ProcessInfo.processInfo.environment["CongressGov_API_Key"]!}
    }
    
    func getMaxPagination(bioGuideID: String, completion: @escaping (Int) -> Void) {
       let url = createSponsoredLegislationURL(bioGuideID: bioGuideID, pageOffset: 0)
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
            do {
                let sponsoredLegislationPackage = try JSONDecoder().decode(SponsoredLegislationPackage.self, from: data)
                let maxPagination = sponsoredLegislationPackage.pagination.count
                return completion(maxPagination)
                
            } catch {
                print("Unexpected error: \(error).")
            }
        }.resume()
    }
    
    
    
    func createSponsoredLegislationURL(bioGuideID: String, pageOffset: Int) -> URL {
        
        let sponsoredLegislationURL = URL(string: "https://api.congress.gov/v3/member/\(bioGuideID)/sponsored-legislation?api_key=\(openStatesAPIKey)&offset=\(pageOffset)&limit=250&format=json"
        )
        
        return sponsoredLegislationURL!
    }
    
    func getSponsoredLegislationPackage(from url: URL, completion: @escaping (Swift.Result<SponsoredLegislationPackage, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(error!))
                return
            }

            do {
                let sponsoredLegislationPackage = try JSONDecoder().decode(SponsoredLegislationPackage.self, from: data)
                return completion(.success(sponsoredLegislationPackage))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
        
    }
    
    
}

