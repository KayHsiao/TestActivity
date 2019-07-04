//
//  MyCollectedViewController.swift
//  0610
//
//  Created by Chris on 2019/7/3.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class MyCollectedViewController: UIViewController {

    var cafes: [Cafe] = []
    var searchResult: [Cafe] = []

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        getJSON()
    }

    func setupNavigationBar() {
        // NavigationBar
        self.title = "我的收藏"

        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.backgroundColor = UIColor(named: "Green 2")
            navigationController?.navigationBar.barTintColor = UIColor(named: "Green 2")
        } else {
            // Fallback on earlier versions
            navigationController?.navigationBar.backgroundColor = UIColor(hexString: "00B156")
            navigationController?.navigationBar.barTintColor = UIColor(hexString: "00B156")
        }
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        } else {
            // Fallback on earlier versions
        }
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none

        tableView.register(nibWithCellClass: CafeTableViewCell.self)
    }

    @objc func getJSON() {
        requestManager.getYilanCafe { [weak self] (cafes) in
            guard let strongSelf = self else { return }

            var myCafes: [Cafe] = []

            for cafe in cafes {
                let isCollected = UserDefaults.standard.bool(forKey: cafe.id)
                if isCollected {
                    myCafes.append(cafe)
                }
            }

            strongSelf.cafes = myCafes
            strongSelf.tableView.reloadData()
        }
    }

}

extension MyCollectedViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CafeTableViewCell", for: indexPath) as! CafeTableViewCell
        cell.selectionStyle = .none

        cell.delegate = self

        cell.indexPath = indexPath

        let cafe = cafes[indexPath.row]
        cell.cafe = cafe

        return cell
    }
}

extension MyCollectedViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cafe = cafes[indexPath.row]
        if let url = URL(string: cafe.url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(url)
            }
        }
    }

}

extension MyCollectedViewController: CafeTableViewCellDelegate {

    func didClickCollectButton(_ sender: UIButton, at indexPath: IndexPath) {
        var cafe: Cafe

        cafe = cafes[indexPath.row]

        let isCollected = UserDefaults.standard.bool(forKey: cafe.id)
        if isCollected {
            UserDefaults.standard.set(false, forKey: cafe.id)
        } else {
            UserDefaults.standard.set(true, forKey: cafe.id)
        }
        UserDefaults.standard.synchronize()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

}
