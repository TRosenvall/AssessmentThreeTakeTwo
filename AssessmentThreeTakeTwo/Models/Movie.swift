//
//  Movie.swift
//  AssessmentThreeTakeTwo
//
//  Created by Timothy Rosenvall on 6/28/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation

struct TopLevelJSON: Decodable {
    var results: [Result]
}

struct Result: Decodable {
    let id: Int
    let vote_average: Double
    let title: String
    let poster_path: String?
    let overview: String
}
