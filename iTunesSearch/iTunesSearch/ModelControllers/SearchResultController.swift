//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Jeff Kang on 9/26/20.
//

import Foundation

class SearchResultController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultTypeQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion(NSError())
            return
        }
//        print(requestURL)
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            if let error = error {
                print("error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let self = self else {
                completion(NSError())
                return
            }
            
            guard let data = data else {
                print("no data returned from data task")
                completion(NSError())
                return
            }
//            print(data)
            let jsonDecoder = JSONDecoder()
            
            do {
                let searchedResults = try
                    jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: searchedResults.results)
                completion(nil)
            } catch {
                print("Unable to decode data into object of type SearchResults: \(error)")
                completion(error)
                return
            }
//            completion()
        }.resume()
    }
}
