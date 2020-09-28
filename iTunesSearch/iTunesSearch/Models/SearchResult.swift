//
//  File.swift
//  iTunesSearch
//
//  Created by Jeff Kang on 9/26/20.
//

import Foundation

struct SearchResult: Codable {
    
    let title: String
    let creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
