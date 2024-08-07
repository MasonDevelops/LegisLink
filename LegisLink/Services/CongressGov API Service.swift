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
    func getTermsInCongress(bioGuideID: String, completion: @escaping ([Term]) -> Void)
    func getCurrentDayLegislation(completion: @escaping ([Bill]) -> Void)
}

class CongressGovService: CongressGovServiceProtocol {
    
    
    private var congressGovAPIKey: String {
        get {return Environment.congressGovAPI}
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
        
        let sponsoredLegislationURL = URL(string: "https://api.congress.gov/v3/member/\(bioGuideID)/sponsored-legislation?api_key=\(congressGovAPIKey)&offset=\(pageOffset)&limit=250&format=json"
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
    
    func getTermsInCongress(bioGuideID: String, completion: @escaping ([Term]) -> Void) {
        
        let url = URL(string: "https://api.congress.gov/v3/member/\(bioGuideID)?api_key=\(congressGovAPIKey)")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        URLSession.shared.dataTask(with: url!) { (data, _, _) in
            guard let data = data else {return}
            do {
                let congressGovMemberRequest = try JSONDecoder().decode(CongressGovMemberRequest.self, from: data)
                return completion(congressGovMemberRequest.member.terms)
            } catch {
                print("Unexpected error: \(error).")
            }
        }.resume()
    }
    
    
    func getCurrentDayLegislation(completion: @escaping ([Bill]) -> Void) {
        
        let currentDateTime = Date()
        
        let calendar = Calendar.current
        
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
        ]
        
        let dateTimeComponents = calendar.dateComponents(requestedComponents, from: currentDateTime)
        
        let beginningOfCurrentDate = "\(String(describing: dateTimeComponents.year!))-\(String(describing: dateTimeComponents.month!))-\(String(describing: dateTimeComponents.day!))T00:00:00Z"
        
        let endOfCurrentDate = "\(String(describing: dateTimeComponents.year!))-\(String(describing: dateTimeComponents.month!))-\(String(describing: dateTimeComponents.day!))T23:59:59Z"

        let url = URL(string: "https://api.congress.gov/v3/bill/118?fromDateTime=\(beginningOfCurrentDate)&\(endOfCurrentDate)&sort=updateDate+desc&api_key=\(congressGovAPIKey)")
        
        URLSession.shared.dataTask(with: url!) { (data, _, _) in
            guard let data = data else {return}
            do {
                let getCurrentDayBillsResponse = try JSONDecoder().decode(GetDailyBillsResponse.self, from: data)
                return completion(getCurrentDayBillsResponse.bills)
            } catch {
                print("Unexpected error: \(error).")
            }
        }.resume()
        
    }
}


