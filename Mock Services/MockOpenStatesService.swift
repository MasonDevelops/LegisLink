//
//  MockOpenStatesService.swift
//  FindYourRepTests
//
//  Created by Mason Cochran on 8/5/23.
//

import Foundation


@testable import LegisLink

class MockOpenStatesService: OpenStatesServiceProtocol {
    
    func getMaxCommitteePages(from chamber: String, completion: @escaping (Int) -> Void) {
        return completion(2)
    }
    
//    func getSenateCommitteeData(from currentPage: Int, completion: @escaping (Swift.Result<CommitteeList, Error>) -> Void) {
//        guard let url = Bundle(for: MockGoogleCivicInfoService.self).url(forResource: "successful-open-states-upper-house-committee-request-page-\(currentPage)", withExtension: "json"),
//              let data = try? Data(contentsOf: url) else { return }
//        let committeeList = try? JSONDecoder().decode(CommitteeList.self, from: data)
//        completion(.success(committeeList!))
//    }
//    
//    func getHouseCommitteeData(from currentPage: Int, completion: @escaping (Swift.Result<CommitteeList, Error>) -> Void) {
//        guard let url = Bundle(for: MockGoogleCivicInfoService.self).url(forResource: "successful-open-states-lower-house-committee-request-page-\(currentPage)", withExtension: "json"),
//              let data = try? Data(contentsOf: url) else { return }
//        let committeeList = try? JSONDecoder().decode(CommitteeList.self, from: data)
//        completion(.success(committeeList!))
//    }
    
    
    
    func getCommitteeData(from chamber: String, currentPage: Int, completion: @escaping (Swift.Result<CommitteeList, Error>) -> Void) {
        
        if (chamber == "house") {
            guard let url = Bundle(for: MockGoogleCivicInfoService.self).url(forResource: "successful-open-states-lower-house-committee-request-page-\(currentPage)", withExtension: "json"),
                  let data = try? Data(contentsOf: url) else { return }
            let committeeList = try? JSONDecoder().decode(CommitteeList.self, from: data)
            completion(.success(committeeList!))
        }
        
        else {
            guard let url = Bundle(for: MockGoogleCivicInfoService.self).url(forResource: "successful-open-states-upper-house-committee-request-page-\(currentPage)", withExtension: "json"),
                let data = try? Data(contentsOf: url) else { return }
            let committeeList = try? JSONDecoder().decode(CommitteeList.self, from: data)
            completion(.success(committeeList!))
        }
        
        

    }
    
}



