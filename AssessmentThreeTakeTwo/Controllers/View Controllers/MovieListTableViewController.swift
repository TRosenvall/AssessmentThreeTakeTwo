//
//  MovieListTableViewController.swift
//  AssessmentThreeTakeTwo
//
//  Created by Timothy Rosenvall on 6/28/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {

    @IBOutlet weak var searchBarText: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieController.sharedInstance.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {return UITableViewCell()}
        let movie = MovieController.sharedInstance.movies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.ratingLabel.text = "\(movie.vote_average)"
        cell.overviewLabel.text = movie.overview
        MovieController.sharedInstance.fetchPosterImage(movie: movie) { (poster) in
            cell.posterImageView.image = poster
        }
        return cell
    }
}

extension MovieListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, searchTerm != "" else {return}
        
        MovieController.sharedInstance.fetchSearchResults(searchText: searchTerm, completion: { (results) in
            if let unwrappedSearchResults = results {
                MovieController.sharedInstance.movies = unwrappedSearchResults
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
}
