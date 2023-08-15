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
                var contributors = try JSONDecoder().decode(Contributors.self, from: data)
                
                let formatter = NumberFormatter()

                for index in contributors.response.contributors.contributor.indices {
                    formatter.numberStyle = .currency
                    
                    var doubleVersion = Double(contributors.response.contributors.contributor[index].attributes.total)
                    
                    let formattedValue = formatter.string(for: doubleVersion)
                    
                    
                    contributors.response.contributors.contributor[index].attributes.total = formattedValue!
                }
                
                completion(.success(contributors))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
    
    
    
}

