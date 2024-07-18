//
//  OpenStates API Service.swift
//  town square
//
//  Created by Mason Cochran on 8/4/23.
//

import Foundation




protocol OpenStatesServiceProtocol {
    func getMaxCommitteePages(from chamber: String, completion: @escaping (Int) -> Void)
//    func getSenateCommitteeData(from currentPage: Int, completion: @escaping (Swift.Result<CommitteeList, Error>) -> Void)
//    func getHouseCommitteeData(from currentPage: Int, completion: @escaping (Swift.Result<CommitteeList, Error>) -> Void)
    func getCommitteeData(from chamber: String, currentPage: Int, completion: @escaping (Swift.Result<CommitteeList, Error>) -> Void)

}



class OpenStatesService: OpenStatesServiceProtocol {
    
    private var openStatesAPIKey: String {
        get {return Environment.openStatesAPI}
    }
    
    func getMaxCommitteePages(from chamber: String, completion: @escaping (Int) -> Void) {
        guard let url = URL(string: "https://v3.openstates.org/committees?jurisdiction=ocd-jurisdiction%2Fcountry%3Aus%2Fgovernment&classification=committee&chamber=\(chamber)&include=memberships&apikey=\(openStatesAPIKey)&page=1&per_page=20")
        else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
            do {
                let senateCommitteeList = try JSONDecoder().decode(CommitteeList.self, from: data)
                let maxPage = senateCommitteeList.pagination.maxPage
                return completion(maxPage)
                
            } catch {
                print("Unexpected error: \(error).")
            }
        }.resume()
    }
    
//    func getSenateCommitteeData(from currentPage: Int, completion: @escaping (Swift.Result<CommitteeList, Error>) -> Void) {
//        
//        guard let url = URL(string: "https://v3.openstates.org/committees?jurisdiction=ocd-jurisdiction%2Fcountry%3Aus%2Fgovernment&classification=committee&chamber=upper&include=memberships&apikey=\(openStatesAPIKey)&page=\(currentPage)&per_page=20")
//        else { return }
//        
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(error!))
//                return
//            }
//
//            do {
//                let committee = try JSONDecoder().decode(CommitteeList.self, from: data)
//                completion(.success(committee))
//            } catch {
//                completion(.failure(error))
//            }
//        }
//        .resume()
//        
//    }
    
    
    
//    func getHouseCommitteeData(from currentPage: Int, completion: @escaping (Swift.Result<CommitteeList, Error>) -> Void) {
//        
//        guard let url = URL(string: "https://v3.openstates.org/committees?jurisdiction=ocd-jurisdiction%2Fcountry%3Aus%2Fgovernment&classification=committee&chamber=lower&include=memberships&apikey=\(openStatesAPIKey)&page=\(currentPage)&per_page=20")
//        else { return }
//        
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(error!))
//                return
//            }
//
//            do {
//                let committee = try JSONDecoder().decode(CommitteeList.self, from: data)
//                completion(.success(committee))
//            } catch {
//                completion(.failure(error))
//            }
//        }
//        .resume()
//        
//    }
    
    
    func getCommitteeData(from chamber: String, currentPage: Int, completion: @escaping (Swift.Result<CommitteeList, Error>) -> Void) {
        
        guard let url = URL(string: "https://v3.openstates.org/committees?jurisdiction=ocd-jurisdiction%2Fcountry%3Aus%2Fgovernment&classification=committee&chamber=\(chamber)&include=memberships&apikey=\(openStatesAPIKey)&page=\(currentPage)&per_page=20")
        else { return }
        
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
                let committee = try JSONDecoder().decode(CommitteeList.self, from: data)
                completion(.success(committee))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
        
    }
   
}

