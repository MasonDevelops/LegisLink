//
//  MockCongressGovService.swift
//  FindYourRepTests
//
//  Created by Mason Cochran on 10/21/23.
//

import Foundation


@testable import LegisLink

class MockCongressGovService: CongressGovServiceProtocol {


    func getMaxPagination(bioGuideID: String, completion: @escaping (Int) -> Void) {
        if (bioGuideID == "M001198") {
            return completion(384)
        } else if (bioGuideID == "L000266") {
            return completion(15)
        } else if (bioGuideID == "M000934") {
            return completion(643)
        } else {
            return completion(-1)
        }
    }
    
    
    
    func createSponsoredLegislationURL(bioGuideID: String, pageOffset: Int) -> URL {
        
        let congressGovKey = ProcessInfo.processInfo.environment["CongressGov_API_Key"]

        
        let sponsoredLegislationURL = URL(string: "https://api.congress.gov/v3/member/\(bioGuideID)/sponsored-legislation?api_key=\(congressGovKey)&offset=\(pageOffset)&limit=250&format=json"
        )
        
        return sponsoredLegislationURL!
    }
    
    func getSponsoredLegislationPackage(from url: URL, completion: @escaping (Swift.Result<SponsoredLegislationPackage, Error>) -> Void) {
        var urlString = url.absoluteString
        
        if (urlString.contains("L000266")) {
            guard let url = Bundle(for: MockCongressGovService.self).url(forResource: "jake-laturner-sponsored-legislation-offset-0", withExtension: "json"),
                  let data = try? Data(contentsOf: url) else { return }
            let spkglegis = try? JSONDecoder().decode(SponsoredLegislationPackage.self, from: data)
            completion(.success(spkglegis!))
        }
        
        else if (urlString.contains("M001198")) {
            if (urlString.contains("&offset=0")) {
                guard let url = Bundle(for: MockCongressGovService.self).url(forResource: "roger-marshall-sponsored-legislation-offset-0", withExtension: "json"),
                      let data = try? Data(contentsOf: url) else { return }
                let spkglegis = try? JSONDecoder().decode(SponsoredLegislationPackage.self, from: data)
                completion(.success(spkglegis!))
            } else {
                guard let url = Bundle(for: MockCongressGovService.self).url(forResource: "roger-marshall-sponsored-legislation-offset-250", withExtension: "json"),
                      let data = try? Data(contentsOf: url) else { return }
                let spkglegis = try? JSONDecoder().decode(SponsoredLegislationPackage.self, from: data)
                completion(.success(spkglegis!))
            }
        } else {
            if (urlString.contains("&offset=0")) {
                guard let url = Bundle(for: MockCongressGovService.self).url(forResource: "jerry-moran-sponsored-legislation-offset-0", withExtension: "json"),
                      let data = try? Data(contentsOf: url) else { return }
                let spkglegis = try? JSONDecoder().decode(SponsoredLegislationPackage.self, from: data)
                completion(.success(spkglegis!))
            } else if (urlString.contains("&offset=1")) {
                guard let url = Bundle(for: MockCongressGovService.self).url(forResource: "jerry-moran-sponsored-legislation-offset-250", withExtension: "json"),
                      let data = try? Data(contentsOf: url) else { return }
                let spkglegis = try? JSONDecoder().decode(SponsoredLegislationPackage.self, from: data)
                completion(.success(spkglegis!))
            } else {
                guard let url = Bundle(for: MockCongressGovService.self).url(forResource: "jerry-moran-sponsored-legislation-offset-500", withExtension: "json"),
                      let data = try? Data(contentsOf: url) else { return }
                let spkglegis = try? JSONDecoder().decode(SponsoredLegislationPackage.self, from: data)
                completion(.success(spkglegis!))
            }
        }
    }
    
    func getTermsInCongress(bioGuideID: String, completion: @escaping ([Term]) -> Void) {
        
        
        
        if (bioGuideID == "M001198") {
            guard let url = Bundle(for: MockGoogleCivicInfoService.self).url(forResource: "roger-marshall-successful-congress-gov-response", withExtension: "json"),
                  let data = try? Data(contentsOf: url) else { return }
            let memberReq = try? JSONDecoder().decode(CongressGovMemberRequest.self, from: data)
            completion((memberReq?.member.terms)!)
            
        } else if (bioGuideID == "L000266") {
            guard let url = Bundle(for: MockGoogleCivicInfoService.self).url(forResource: "jake-laturner-successful-congress-gov-response", withExtension: "json"),
                  let data = try? Data(contentsOf: url) else { return }
            let memberReq = try? JSONDecoder().decode(CongressGovMemberRequest.self, from: data)
            completion((memberReq?.member.terms)!)
        } else if (bioGuideID == "M000934") {
            guard let url = Bundle(for: MockGoogleCivicInfoService.self).url(forResource: "jerry-moran-successful-congress-gov-response", withExtension: "json"),
                  let data = try? Data(contentsOf: url) else { return }
            let memberReq = try? JSONDecoder().decode(CongressGovMemberRequest.self, from: data)
            completion((memberReq?.member.terms)!)
        }
        
    }
    
    func getCurrentDayLegislation(completion: @escaping ([Bill]) -> Void) {
        //return stuff
    }
    
}
