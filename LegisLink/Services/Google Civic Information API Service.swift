//
//  Google Civic Information API Service.swift
//  town square
//
//  Created by Mason Cochran on 8/4/23.
//

import Foundation


protocol GoogleCivicInfoServiceProtocol {
    func getReps(from url: URL, completion: @escaping (Swift.Result<Reps, Error>) -> Void)
}

class GoogleCivicInfoService: GoogleCivicInfoServiceProtocol {
    
    private var googleAPIKey: String {
        get {return Environment.googleCivicInformationAPI}
    }
    
    func getReps(from url: URL, completion: @escaping (Swift.Result<Reps, Error>) -> Void) {
        
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
                let lawmakers = try JSONDecoder().decode(Reps.self, from: data)
                completion(.success(lawmakers))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
}






