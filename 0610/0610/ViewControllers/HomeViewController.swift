//
//  HomeViewController.swift
//  0610
//
//  Created by Chris on 2019/6/11.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import SwiftyJSON

enum CafeRatingType {
    case wifi
    case seat
    case quiet
    case tasty
    case cheap
    case music
}

class HomeViewController: UIViewController {

    var cafes: [Cafe] = []
    var searchResult: [Cafe] = []

    @IBOutlet weak var tableView: UITableView!

//    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    var vcType: MyViewControllerType!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        getJSON()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.barStyle = .black
    }

    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "xinxi"), style: .plain, target: self, action: #selector(showSortActions))

        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.backgroundColor = UIColor(named: "Green 2")
        } else {
            // Fallback on earlier versions
        }
        navigationController?.navigationBar.barTintColor = UIColor(named: "Green 2")
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        //        navigationController?.navigationBar.setColors(background: UIColor(hexString: "7CE2FF"), text: UIColor.whi)

        navigationItem.searchController = UISearchController(searchResultsController: nil)
        self.definesPresentationContext = true

        navigationItem.searchController?.searchResultsUpdater = self
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        //        navigationItem.searchController?.hidesNavigationBarDuringPresentation = true

        navigationItem.searchController?.searchBar.sizeToFit()
        navigationItem.searchController?.searchBar.placeholder = "搜尋店家名稱、地址"
        navigationItem.searchController?.searchBar.tintColor = .white
        navigationItem.searchController?.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = true
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }

    func getJSON() {
        requestManager.getYilanCafe { [weak self] (cafes) in
            guard let strongSelf = self else { return }
            strongSelf.cafes = cafes
            strongSelf.tableView.reloadData()
        }
    }

    func filterContentForSearchText(searchText: String?) {
        guard let searchText = searchText, !searchText.isEmpty else {
            searchResult.removeAll()
            return
        }

        searchResult = cafes.filter({ (cafe) -> Bool in
            if cafe.name.lowercased().range(of: searchText.lowercased()) != nil {
                return true
            }
            if cafe.address.lowercased().range(of: searchText.lowercased()) != nil {
                return true
            }
            return false
        })
    }

    @objc func showSortActions() {
        let alertController = UIAlertController.init(title: "依種類排序", message: "由大到小", preferredStyle: .actionSheet)
        alertController.addAction(title: "WIFI穩定", style: .default, isEnabled: true) { (action) in
            self.sortCafes(with: .wifi)
        }
        alertController.addAction(title: "通常有位", style: .default, isEnabled: true) { (action) in
            self.sortCafes(with: .seat)
        }
        alertController.addAction(title: "安靜程度", style: .default, isEnabled: true) { (action) in
            self.sortCafes(with: .quiet)
        }
        alertController.addAction(title: "咖啡好喝", style: .default, isEnabled: true) { (action) in
            self.sortCafes(with: .tasty)
        }
        alertController.addAction(title: "價格便宜", style: .default, isEnabled: true) { (action) in
            self.sortCafes(with: .cheap)
        }
        alertController.addAction(title: "裝潢音樂", style: .default, isEnabled: true) { (action) in
            self.sortCafes(with: .music)
        }
        alertController.addAction(title: "取消", style: .cancel, isEnabled: true) { (action) in
            //
        }
        alertController.show()
    }

    func sortCafes(with type: CafeRatingType) {
        switch type {
        case .wifi:
            cafes.sort { (a, b) -> Bool in
                return a.wifi > b.wifi
            }
            tableView.reloadData()
        case .seat:
            cafes.sort { (a, b) -> Bool in
                return a.seat > b.seat
            }
            tableView.reloadData()
        case .quiet:
            cafes.sort { (a, b) -> Bool in
                return a.quiet > b.quiet
            }
            tableView.reloadData()
        case .cheap:
            cafes.sort { (a, b) -> Bool in
                return a.cheap > b.cheap
            }
            tableView.reloadData()
        case .music:
            cafes.sort { (a, b) -> Bool in
                return a.music > b.music
            }
            tableView.reloadData()
        case .tasty:
            cafes.sort { (a, b) -> Bool in
                return a.tasty > b.tasty
            }
            tableView.reloadData()
        }
    }

}

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if navigationItem.searchController!.isActive {
            return searchResult.count
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
            let cafe = searchResult[indexPath.row]
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
        if navigationItem.searchController!.isActive {
            let cafe = searchResult[indexPath.row]
            if let url = URL(string: cafe.url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            let cafe = cafes[indexPath.row]
            if let url = URL(string: cafe.url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

}

extension HomeViewController: CafeTableViewCellDelegate {

    func didClickCollectButton(_ sender: UIButton, at indexPath: IndexPath) {
        //
    }

}

extension HomeViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText: searchText)
        tableView.reloadData()
    }

}

extension HomeViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//    }

//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//    }

}
