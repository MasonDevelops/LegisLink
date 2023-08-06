//
//  OpenSecrets API Service.swift
//  town square
//
//  Created by Mason Cochran on 8/4/23.
//

import Foundation



protocol OpenSecretsServiceProtocol {
    func getTopContributors(from url: URL, completion: @escaping (Swift.Result<Contributors, Error>) -> Void)
}



class OpenSecretsService: OpenSecretsServiceProtocol {
    func getTopContributors(from url: URL, completion: @escaping (Swift.Result<Contributors, Error>) -> Void) {
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
                let contributors = try JSONDecoder().decode(Contributors.self, from: data)
                completion(.success(contributors))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
    
    
    
}

