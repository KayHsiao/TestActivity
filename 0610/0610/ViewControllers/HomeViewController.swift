//
//  HomeViewController.swift
//  0610
//
//  Created by Chris on 2019/6/11.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: UIViewController {

    var cafes: [Cafe] = []
    var searchCafes: [Cafe] = []

    @IBOutlet weak var tableView: UITableView!

//    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    var vcType: MyViewControllerType!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        getJSON()
    }

    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "xinxi"), style: .plain, target: self, action: nil)

        navigationController?.navigationBar.backgroundColor = UIColor(hexString: "7CE2FF")
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "7CE2FF")
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        //        navigationController?.navigationBar.setColors(background: UIColor(hexString: "7CE2FF"), text: UIColor.whi)

        navigationItem.searchController = UISearchController(searchResultsController: nil)
        self.definesPresentationContext = true
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false

        navigationItem.searchController?.searchBar.sizeToFit()
        navigationItem.searchController?.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }

    func getJSON() {
        cafes = []
//        activityIndicatorView.startAnimating()
//        infoLabel.isHidden = true

        requestManager.getYilanCafe { [weak self] (json) in
            log.info(json)
            guard let strongSelf = self else { return }

//            strongSelf.activityIndicatorView.stopAnimating()

            let cafeArray = json.arrayValue
            log.info("cafeArray count is \(cafeArray.count)")

            for key in cafeArray {
                let cafe = Cafe(name: key["name"].stringValue, address: key["address"].stringValue, wifi: key["wifi"].intValue, seat: key["seat"].intValue, quiet: key["quiet"].intValue, tasty: key["tasty"].intValue, cheap: key["cheap"].intValue, music: key["music"].intValue)
                strongSelf.cafes.append(cafe)
            }

            strongSelf.tableView.reloadData()
        }


        //                let session = URLSession.shared
        //
        //                let url = URL(string: "https://cafenomad.tw/api/v1.2/cafes/taipei")!
        //
        //                let task = session.dataTask(with: url) { data, response, error in
        //
        //                    if error != nil || data == nil {
        //                        print("Client error!")
        //                        return
        //                    }
        //
        //                    guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
        //                        print("Server error!")
        //                        return
        //                    }
        //
        //                    guard let mime = response.mimeType, mime == "application/json" else {
        //                        print("Wrong MIME type!")
        //                        return
        //                    }
        //
        //                    do {
        //                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
        //                        print(json)
        //                    } catch {
        //                        print("JSON error: \(error.localizedDescription)")
        //                    }
        //                }
        //
        //                task.resume()
    }

    func searchCafe(query: String?) {
        guard let query = query, !query.isEmpty else {
            return
        }

        searchCafes = []

        for cafe in cafes {
            if cafe.name.hasPrefix(query) || cafe.address.hasPrefix(query) {
                searchCafes.append(cafe)
            }
        }

        tableView.reloadData()
    }

}

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if navigationItem.searchController!.isActive {
            return searchCafes.count
        } else {
            return cafes.count
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CafeTableViewCell", for: indexPath) as! CafeTableViewCell
        cell.selectionStyle = .none

        cell.delegate = self

        cell.indexPath = indexPath

        if navigationItem.searchController!.isActive {
            let cafe = searchCafes[indexPath.row]
            cell.cafe = cafe
        } else {
            let cafe = cafes[indexPath.row]
            cell.cafe = cafe
        }

        return cell
    }

}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }

}

extension HomeViewController: CafeTableViewCellDelegate {

    func didClickCollectButton(_ sender: UIButton, at indexPath: IndexPath) {
        //
    }

}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
}

extension HomeViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        searchCafe(query: searchBar.text)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        searchCafes.removeAll()
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCafe(query: searchBar.text)
    }

}
