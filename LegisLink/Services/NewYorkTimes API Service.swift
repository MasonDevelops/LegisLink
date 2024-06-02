//
//  ProPublica API Service.swift
//  LegisLink
//
//  Created by Mason Cochran on 3/10/24.
//

import Foundation

protocol NewYorkTimesServiceProtocol {
    func getDailyCongressionalNews(completion: @escaping (Swift.Result<[Doc], Error>) -> Void)
    func buildURL() -> URL
}

class NewYorkTimesService: NewYorkTimesServiceProtocol {
    
    private var NYTAPIKey: String {
        get {return Environment.nytAPI}
    }
    
    func buildURL() -> URL {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.d"
        let today = Date()
        
        let todayRaw = dateFormatter.string(from: today)
        
        let beginDate = todayRaw.replacingOccurrences(of: ".", with: "")
        

        
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        
        let endDateRaw = dateFormatter.string(from: tomorrow)
        
        let endDate = endDateRaw.replacingOccurrences(of: ".", with: "")

        

        let url = URL(string: "https://api.nytimes.com/svc/search/v2/articlesearch.json?begin_date=\(beginDate)&end_date=\(endDate)&facet=true&facet_fields=news_desk&facet_filter=true&q=congress&sort=newest&api-key=\(NYTAPIKey)")
        
        return url!
    }
    
    func getDailyCongressionalNews(completion: @escaping (Swift.Result<[Doc], Error>) -> Void) {
        let url = buildURL()
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }

            
            do {
                let nytResponse = try JSONDecoder().decode(NYTRequest.self, from: data)
                let docs = nytResponse.response.docs
                return completion(.success(docs))
                
            } catch let DecodingError.dataCorrupted(context) {
                 print(context)
             } catch let DecodingError.keyNotFound(key, context) {
                 print("Key '\(key)' not found:", context.debugDescription)
                 print("codingPath:", context.codingPath)
             } catch let DecodingError.valueNotFound(value, context) {
                 print("Value '\(value)' not found:", context.debugDescription)
                 print("codingPath:", context.codingPath)
             } catch let DecodingError.typeMismatch(type, context)  {
                 print("Type '\(type)' mismatch:", context.debugDescription)
                 print("codingPath:", context.codingPath)
             } catch {
                 print("error: ", error)
             }
        }.resume()
    }
    
}







