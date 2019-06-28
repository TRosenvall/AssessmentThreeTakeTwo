//
//  MovieController.swift
//  AssessmentThreeTakeTwo
//
//  Created by Timothy Rosenvall on 6/28/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import UIKit

class MovieController {
    
    static let sharedInstance = MovieController()
    
    var movies: [Result] = []
    
    func fetchSearchResults (searchText: String, completion: @escaping ([Result]?) -> Void) {
        guard let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie") else {completion(nil); return}
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let apiKey = URLQueryItem(name: "api_key", value: "fa9ce6a782cd416cbafdd5025fe42d0e")
        let searchTextQuery = URLQueryItem(name: "query", value: searchText)
        components?.queryItems = [apiKey, searchTextQuery]
        guard let finalURL = components?.url else {completion(nil);return}
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil);return
            } else if let data = data {
                let decoder = JSONDecoder()
                do{
                    let searchResult = try decoder.decode(TopLevelJSON.self, from: data)
                    completion(searchResult.results); return
                } catch {
                    print(error.localizedDescription)
                    completion(nil);return
                }
            }
        }.resume()
    }
    
    static func fetchPosterImage (movie: Result, completion: @escaping (UIImage?) -> Void ) {
        guard let baseURL = URL(string: "https://image.tmdb.org/t/p/w500/") else {completion(nil);return}
        guard let path = movie.poster_path else {completion(nil);return}
        let finalURL = baseURL.appendingPathComponent(path)
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil);return
            } else if let data = data {
                let poster = UIImage(data: data)
                completion(poster);return
            }
        }.resume()
    }
}
